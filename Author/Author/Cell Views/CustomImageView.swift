//
//  CustomImageView.swift
//  Author
//
//  Created by Seema Sharma on 11/9/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

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
        
        if let imageFromCache = CacheManager.sharedInstance.getObjectFromCache(key: urlString) as? UIImage {
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
                    CacheManager.sharedInstance.storeResponse(key: urlString, value: imageToCache)
                }
            }
        }.resume()
    }
}
