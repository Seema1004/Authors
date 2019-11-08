//
//  AuthorPostTests.swift
//  AuthorTests
//
//  Created by Seema Sharma on 11/8/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import XCTest
@testable import Author

class AuthorPostTests: XCTestCase {
    var networkManager = MockNetworkManager()
    var postVC = PostsTableViewController()
    
    override func setUp() {
        super.setUp()
        networkManager.jsonResonse = [
            [
                "id" : 1,
                "date" : "2017-12-05T02:18:18.571Z",
                "title" : "Quis doloribus libero ipsam.",
                "body" : "Quibusdam nemo dolor cum. Nihil et nisi atque ut earum magnam dolorem quia. Eveniet deleniti et voluptatem molestiae. Rerum nostrum nam illum et corrupti soluta fugit voluptate. Error assumenda qui rerum dolor.",
                "imageUrl" : "https://picsum.photos/id/146/640/480",
                "authorId" : 1
            ],
            [
                "id" : 2,
                "date" : "2017-09-21T18:52:15.696Z",
                "title" : "Ex quia voluptatem autem nesciunt repellendus consectetur.",
                "body" : "Voluptatem autem quidem delectus ea earum voluptates rem enim consequuntur. Facilis sunt pariatur quisquam sunt est enim molestiae et similique. Veniam laborum est aut iusto at molestiae ut occaecati ex.",
                "imageUrl" : "https://picsum.photos/id/995/640/480",
                "authorId" : 2
            ],
            [
                "id": 97,
                "date": "2017-10-20T15:17:37.054Z",
                "title": "Ut vero sit sint non.",
                "body": "Suscipit eius voluptatem cum. Aspernatur alias dolores inventore voluptates id earum et. Ipsam aut neque et placeat eligendi.",
                "imageUrl": "https://picsum.photos/id/230/640/480",
                "authorId": 1
            ]
        ]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testfetchPostsForAuthor() {
        let promise = expectation(description: "fetch post list excuted successfully")
        
        //self.networkManager.networkResponseError = true // set this for a failure case.
        let urlString = "https://mockUrl/posts?authorId=1&_page=1&_limit=20"
        
        self.networkManager.executeRequestFor(url: urlString) { (status, responseData) in
            if status == false {
                if responseData == nil {
                    XCTFail()
                    return
                }
            } else {
                do {
                    if let listData = responseData {
                        self.postVC.postList = try JSONDecoder().decode([Posts].self, from: listData)
                        
                        XCTAssertNotNil(self.postVC.postList)
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
