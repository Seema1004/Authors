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
}
