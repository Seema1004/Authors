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
    var jsonResonse: [[String: Any]] = []
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
