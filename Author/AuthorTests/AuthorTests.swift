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
        
        let promise = expectation(description: "authors list successfully fetched")
        
        self.networkManager.executeRequestFor(url: "https:\\mockUrl") { (status, responseData) in
            if status {
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
