//
//  MockNetworkManager.swift
//  AuthorTests
//
//  Created by Seema Sharma on 11/7/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit
@testable import Author

class MockNetworkManager {
    var networkResponseError = false
    
    var jsonResonse: [[String: Any]] = [[
        "id" : 1,
        "name": "Leigh Kessler",
        "userName": "Myrtie_Heller51",
        "email": "vance_hansen7@yahoo.com",
        "avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/nutzumi/128.jpg",
        "address": [
            "latitude": "73.5451",
            "longitude": "155.4534"
        ]],
        [
        "id" : 2,
        "name": "Homer Bradtke Jr.",
        "userName": "Trinity.Feeney46",
        "email": "moriah.zulauf@gmail.com",
        "avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/nelshd/128.jpg",
        "address": [
            "latitude": "50.8177",
            "longitude": "152.4155"
        ]]
    ]
    
    
}

extension MockNetworkManager: NetworkManagerProtocol {
    
    func executeRequestFor(url: String, completionHandler: @escaping (Bool, Data?) -> Void) {
        if networkResponseError {
            completionHandler(false, nil)
        } else {
            if let data = try? JSONSerialization.data(withJSONObject: jsonResonse, options: []) {
                completionHandler(true,data)
            }
        }
    }
}
