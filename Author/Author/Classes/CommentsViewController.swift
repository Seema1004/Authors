//
//  CommentsViewController.swift
//  Author
//
//  Created by Seema Sharma on 11/8/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    var authorPost: Posts?
    var commentsList: [Comment] = []
    fileprivate var pageNumber = 0
    fileprivate var isCommentsBeingFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comments"
        self.fetchCommentsforPost(self.authorPost?.id, self.pageNumber + 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchCommentsforPost(_ id: Int?,_ page: Int) {
        self.pageNumber = page
        self.isCommentsBeingFetched = true
        
        let requestURL = "https://sym-json-server.herokuapp.com/comments?postId=\(self.authorPost?.id ?? 0)&_page=\(page)&_limit=10&_sort=date&_order=asc"
        
        NetworkManager().executeRequestFor(url: requestURL ) { (status, responseData) in
            // reload the table view on the main thread.
            DispatchQueue.main.async {
                do {
                    if let listData = responseData {
                        let lists = try JSONDecoder().decode([Comment].self, from: listData)
                        if self.commentsList.count == 0 {
                            self.commentsList = lists
                        } else {
                            self.commentsList.append(contentsOf: lists)
                        }
                        self.isCommentsBeingFetched = false
                        self.tableView.reloadData()
                    }
                } catch {
                    print (error)
                }
            }
        }
    }
}

extension CommentsViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (section == 0) ? 1 : self.commentsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostsCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostsCell
        if indexPath.section == 0 {
            cell.post = self.authorPost
        } else {
            cell.postComment = self.commentsList[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // helps achive the last row when the scroll view scrolls to the end of the table and allows to fetch the posts for next pages

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            // we check if any server calls are done , do not fetch the next rows.
            
            if !isCommentsBeingFetched {
                print("begin fetch")
                self.fetchCommentsforPost(self.authorPost?.id, self.pageNumber + 1)
            }
        }
    }

}

