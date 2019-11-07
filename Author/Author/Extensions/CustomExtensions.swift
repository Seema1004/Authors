//
//  CustomExtensions.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>() // using <String, UIImage> leads to compile error as String does not conform to AnyObject type. Hence used NString here.

extension UIImageView {
    
    func loadImageUsing(urlString: String) {
        
        let url = URL.init(string: urlString)
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage.init(data: data!) {
                    self.image = imageToCache
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }
        }.resume()
    }
}
