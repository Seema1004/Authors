//
//  CacheManager.swift
//  Author
//
//  Created by Seema Sharma on 11/9/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

//implement a cache class to save images and load from here if available.
class CacheManager: NSCache<NSString, AnyObject> {
    static let sharedInstance = CacheManager()

    func storeResponse(key:String, value: AnyObject) {
        self.setObject(value, forKey: key as NSString)
    }
    
    func getObjectFromCache(key: String) -> AnyObject? {
        return self.object(forKey: key as NSString)
    }
}
