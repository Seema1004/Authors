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
    var postList: [Posts] = []
    fileprivate var pageNumber = 0
    fileprivate var isPostsBeingFetched = false
    private let showCommentVCIdentifier = "showCommentsVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = author?.name
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        self.fetchPostsForAuthor(page: 1)
        self.initializeCellViews()
    }
    
    func initializeCellViews() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
    }
    
    func fetchPostsForAuthor(page:Int = 0) {
        self.pageNumber = page
        self.isPostsBeingFetched = true
        
        let requestURL = "https://sym-json-server.herokuapp.com/posts?authorId=\(self.author?.id ?? 0)&_page=\(page)&_limit=10&_sort=date&_order=asc)"
        
        NetworkManager().executeRequestFor(url: requestURL ) { (status, responseData) in
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showCommentVCIdentifier, let destination = segue.destination as? CommentsViewController, let selectedRow = self.tableView.indexPath(for: sender as! PostsCell) {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            destination.authorPost = self.postList[selectedRow.row]
        }
    }
}

extension PostsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (section == 0) ? 1 : self.postList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.author = self.author
            return cell
        case 1:
            let cell:PostsCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostsCell
            cell.post = self.postList[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.layoutIfNeeded()
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? 100 : UITableView.automaticDimension
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
            
            if !isPostsBeingFetched {
                print("begin fetch")
                self.fetchPostsForAuthor(page: self.pageNumber + 1)
            }
        }
    }

}
