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
    
    enum customError: Error {
        case failed
        case success
    }
    
    func executeRequestFor(url: String, completionHandler: @escaping (Error?, Data?) -> Void) {
        if networkResponseError {
            completionHandler(customError.failed, nil)
        } else {
            if let data = try? JSONSerialization.data(withJSONObject: jsonResonse, options: []) {
                completionHandler(nil,data)
            }
        }
    }
}
