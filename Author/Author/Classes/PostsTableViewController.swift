//
//  PostsTableViewController.swift
//  Author
//
//  Created by Seema Sharma on 11/7/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    var author: Author?
    fileprivate var postList: [Posts] = []
    fileprivate var pageNumber = 0
    fileprivate var isPostsBeingFetched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = author?.name
        self.fetchPostsForAuthor(page: 1)
    }
    
    func fetchPostsForAuthor(page:Int = 0) {
        self.pageNumber = page
        self.isPostsBeingFetched = true
        NetworkManager().executeRequestFor(url: "https://sym-json-server.herokuapp.com/posts?authorId=\(self.author?.id ?? 0)&_page=\(page)&_limit=10)") { (status, responseData) in
            // reload the table view on the main thread.
            DispatchQueue.main.async {
                do {
                    if let listData = responseData {
                        let lists = try JSONDecoder().decode([Posts].self, from: listData)
                        if self.postList.count == 0 {
                            self.postList = lists
                        } else {
                            self.postList.append(contentsOf: lists)
                        }
                        self.isPostsBeingFetched = false
                        self.tableView.reloadData()
                    }
                } catch {
                    print (error)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PostsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.postList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostsCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostsCell
        cell.post = self.postList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.layoutIfNeeded()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // helps achive the last row when the scroll view scrolls to the end of the table and allows to fetch the posts for next pages

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            // we check if any server calls are done , do not fetch the next rows.
            
            if !isPostsBeingFetched {
                print("begin fetch")
                self.fetchPostsForAuthor(page: self.pageNumber + 1)
            }
        }
    }

}
