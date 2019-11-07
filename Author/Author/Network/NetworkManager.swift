//
//  AuthorSessionManager.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

protocol NetworkManagerProtocol {
    func executeRequestFor(url: String, completionHandler: @escaping (Bool, Data?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    fileprivate var dataTask: URLSessionDataTask? // make all the GET requests to server
    fileprivate var defaultSession = URLSession.init(configuration: .default) // creating a default urlsession object
    public typealias CompletionBlock = (Bool, Data?) -> Void // creating a completion block
    
    public func executeRequestFor(url: String, completionHandler: @escaping CompletionBlock) {
        // convert to the url to a non optional object.
        guard let requestUrl = URL.init(string: url) else {
            return // return if url is nil
        }
        
        dataTask = defaultSession.dataTask(with: requestUrl) { (data, response, error) in
            if (error != nil) {
                print ("DataTask error: " +
                    error!.localizedDescription + "\n")
            } else {
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completionHandler(true, data)
                }
            }
        }
        dataTask?.resume()
    }
    
}




