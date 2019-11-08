//
//  Comments.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

/* struct to save the comments added to each of the post posted by Author*/
struct Comment: Codable {
    var id: Int?
    var date: String?
    var body: String?
    var userName: String?
    var email: String?
    var avatarUrl: String?
    var postId: Int?
    
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
