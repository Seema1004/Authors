//
//  Posts.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

/*Struct declared for each of the posts posted by Author*/

struct Posts: Codable {
    var id: Int?
    var date: String?
    var title: String?
    var body: String?
    var imageUrl: String?
    var authorId: Int?
    
    var formattedDate: String? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let newDate = dateFormatter.date(from: date ?? "") {
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                return dateFormatter.string(from: newDate)
            }
            return nil
        }
    }
}
