//
//  PostCommentsTests.swift
//  AuthorTests
//
//  Created by Seema Sharma on 11/9/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import XCTest
@testable import Author

class PostCommentsTests: XCTestCase {

    var networkManager = MockNetworkManager()
    var commentsVC = CommentsViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //read the content from the file
        self.commentsVC.authorPost = Posts.init(id: 1, date: "2017-12-05T02:18:18.571Z", title: "Quis doloribus libero ipsam.", body: "", imageUrl: "", authorId: 1)
        self.loadCommentsList()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func loadCommentsList() {
        networkManager.jsonResonse = [
            ["id": 1,"date": "2016-12-30T23:04:38.084Z","body": "Non maxime eveniet autem officiis ut aliquam. Quos veniam odio officiis eligendi velit quis velit provident. Nobis consequatur molestias. Architecto aut optio ut odit dignissimos enim sequi illum. Dignissimos qui eveniet minus. Explicabo saepe sit nulla.","userName": "Abdiel_Feil93","email": "corbin.hammes@gmail.com","avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/brandclay/128.jpg","postId": 1],
            ["id": 2,"date": "2016-12-30T23:11:55.105Z","body": "Eaque voluptas animi cum. Adipisci impedit nisi est aut placeat rem est quidem vitae. Quibusdam ut deserunt sint cupiditate voluptates consequatur. Dolore iusto deleniti error eos est facere cupiditate eius et. Deserunt rerum asperiores earum odio ratione aperiam laboriosam et.","userName": "Brandi_Bergstrom","email": "curtis_konopelski20@hotmail.com","avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/happypeter1983/128.jpg","postId": 1],
            ["id": 3,"date": "2016-12-30T23:16:32.029Z","body": "Rerum voluptatibus dolores aut sit quod. Omnis magni incidunt. Sunt dolorem eum tempore. Alias fugiat est. Et nihil animi sed earum in.","userName": "Mya_Bechtelar73","email": "clark97@yahoo.com","avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/sreejithexp/128.jpg","postId": 1],
            ["id": 80992,"date": "2016-12-30T23:19:48.126Z","body": "Ipsa eos veniam quam fugit soluta possimus voluptatem. Et alias sint cupiditate corporis. Tenetur mollitia eos aperiam voluptatem commodi libero ea.","userName":"Mireya_OReilly62","email": "tomasa_cummings27@yahoo.com","avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/turkutuuli/128.jpg","postId": 1]
        ]

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
    
    func testfetchCommentsForPost() {
        let promise = expectation(description: "fetch comments list executed successfully")
        
        XCTAssertNotNil(commentsVC.authorPost)
        //self.networkManager.networkResponseError = true // set this for a failure case.
        let urlString = "https://mockUrl/comments?postId=1&_page=1&_limit=20&_sort=date&_order=asc"
        
        self.networkManager.executeRequestFor(url: urlString) { [weak self] (error, responseData) in
            guard let weakSelf = self else { return }
            if error != nil {
                if responseData == nil {
                    XCTFail()
                    return
                }
            } else {
                do {
                    if let listData = responseData {
                        let lists: [Comment] = try JSONDecoder().decode([Comment].self, from: listData)
                        weakSelf.commentsVC.commentsList = lists.filter( { $0.postId == weakSelf.commentsVC.authorPost?.id })
                        XCTAssert(weakSelf.commentsVC.commentsList.count > 0)
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
