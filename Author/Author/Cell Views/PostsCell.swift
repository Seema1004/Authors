//
//  PostsCell.swift
//  Author
//
//  Created by Seema Sharma on 11/7/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    var post: Posts? {
        didSet {
            self.postImageView.loadImageUsing(urlString: post?.imageUrl ?? "")
            self.postTitle.text = post?.title
            self.postBody.text = post?.body
            self.postDate.text = post?.formattedDate
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
