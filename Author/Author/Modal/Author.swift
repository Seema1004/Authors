//
//  Author.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

/* Struct declared to save each author details returned in the list*/

struct Author: Codable {
    var id: Int?
    var name: String?
    var userName: String?
    var email: String?
    var avatarUrl: String?
    var address: Address?
}

/* This is struct to save the address details for each author*/

struct Address: Codable {
    var longitude: String?
    var latitude: String?
}
