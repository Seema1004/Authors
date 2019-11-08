//
//  HeaderCell.swift
//  Author
//
//  Created by Seema Sharma on 11/8/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var authorsImageView: CustomImageView!
    @IBOutlet weak var authorsName: UILabel!
    @IBOutlet weak var authorsEmail: UILabel!
    
    var author: Author? {
        didSet {
            // The name of the author is mentioned as the page title.
            self.authorsImageView.loadImageUsing(urlString: self.author?.avatarUrl ?? "")
            self.authorsName.text = self.author?.userName
            self.authorsEmail.text = self.author?.email
            //TODO: to display the address based on the location coordinates specified.
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        authorsImageView.layer.cornerRadius = authorsImageView.frame.size.width/2
        authorsImageView.clipsToBounds = true
        // Configure the view for the selected state
    }
    
}
