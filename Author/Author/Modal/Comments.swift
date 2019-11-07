//
//  Comments.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

/* struct to save the comments added to each of the post posted by Author*/
struct Comment {
    var id: Int?
    var date: String?
    var body: String?
    var userName: String?
    var email: String?
    var avatarUrl: String?
    var postId: Int?
    
    var formattedDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            return dateFormatter.date(from: date ?? "")
        }
    }
}
