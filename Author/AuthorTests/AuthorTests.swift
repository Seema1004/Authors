//
//  AuthorTests.swift
//  AuthorTests
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import XCTest
@testable import Author

class AuthorTests: XCTestCase {
    var authorView =  AuthorListTableViewController()
    var networkManager = MockNetworkManager()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        networkManager.jsonResonse = [[
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

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchAuthorsList() {
        
        let promise = expectation(description: "fetch authors list excuted successfully")
        
        //self.networkManager.networkResponseError = true // set this for a failure case.
        self.networkManager.executeRequestFor(url: "https:\\mockUrl") { (error, responseData) in
            if (error != nil) {
                if responseData == nil {
                    XCTFail()
                    return
                }
            } else {
                do {
                    if let listData = responseData {
                        self.authorView.authorsList = try JSONDecoder().decode([Author].self, from: listData)
                        XCTAssertNotNil(self.authorView.authorsList)
                        promise.fulfill()
                    }
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
