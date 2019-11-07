//
//  AuthorsCell.swift
//  Author
//
//  Created by Seema Sharma on 11/6/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class AuthorsCell: UITableViewCell {

    @IBOutlet weak var authorsImageView: UIImageView!
    @IBOutlet weak var authorsName: UILabel!
    
    /*
     // set author object in Cell class to access the set the image view.
    */
    var author: Author? {
        didSet {
            self.authorsImageView.loadImageUsing(urlString: self.author?.avatarUrl ?? "")
            self.authorsName.text = self.author?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
