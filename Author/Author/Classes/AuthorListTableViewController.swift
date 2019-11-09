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
    let showPostVCIdentifier = "showPostVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Authors"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchAuthorsList()
    }
    
    func fetchAuthorsList() {
        if authorsList.count == 0 {
            NetworkManager().executeRequestFor(url: "https://sym-json-server.herokuapp.com/authors") { (error, responseData) in
                // reload the table view on the main thread.
                if error != nil {
                    print(error?.localizedDescription ?? "request failed")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        if let listData = responseData {
                            self.authorsList = try JSONDecoder().decode([Author].self, from: listData)
                            if self.authorsList.count > 0 {
                                self.tableView.reloadData()
                            }
                            /*// TODO : To use the user defaults to save the data in offline mode. Need to try a better method like saving the data in Response cache.
                             UserDefaults.standard.set(self.authorsList, forKey: "AuthorsList")
                             */
                        }
                    } catch {
                        print (error)
                    }
                }
            }
        } else {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPostVCIdentifier, let destination = segue.destination as? PostsTableViewController, let selectedRow = self.tableView.indexPath(for: sender as! AuthorsCell) {
            //To change the title of the back button in the navigation bar.
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            destination.author = self.authorsList[selectedRow.row]
        }
    }
}

extension AuthorListTableViewController {
    
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
            cell.accessoryType = .disclosureIndicator
            cell.layoutIfNeeded()
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
