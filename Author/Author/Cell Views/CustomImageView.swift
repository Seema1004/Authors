//
//  CustomImageView.swift
//  Author
//
//  Created by Seema Sharma on 11/9/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>() // using <String, UIImage> leads to compile error as String does not conform to AnyObject type. Hence used NString here

//Using a custom image removes the flickering of images when the table view is scrolled fast.
// the condition check "self.imageUrlString == urlString" checks for the urlString in the async call to load the image for the given cell it is being called for.

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsing(urlString: String) {
        imageUrlString = urlString
        
        if urlString == "" {
            return
        }
        
        let url = URL.init(string: urlString)
        self.image = UIImage.init(named: "placeholder")
        
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
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }
        }.resume()
    }
}
