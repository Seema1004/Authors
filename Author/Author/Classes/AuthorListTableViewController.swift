//
//  AuthorListTableViewController.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class AuthorListTableViewController: UITableViewController {
    
    public var authorsList: [Author] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Authors"
        self.fetchAuthorsList()
    }
    
    func fetchAuthorsList() {
        NetworkManager().executeRequestFor(url: "https://sym-json-server.herokuapp.com/authors") { (status, responseData) in
            // reload the table view on the main thread.
            DispatchQueue.main.async {
                do {
                    if let listData = responseData {
                        self.authorsList = try JSONDecoder().decode([Author].self, from: listData)
                        if self.authorsList.count > 0 {
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print (error)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return authorsList.count
    }

    // when using a prototype cell, the cellIndetifier should be the same in the storyboard and the cellforRow method.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuthorsCell = self.tableView.dequeueReusableCell(withIdentifier: "authorsCell") as! AuthorsCell
        cell.author = self.authorsList[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
