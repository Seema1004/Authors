//
//  PostsCell.swift
//  Author
//
//  Created by Seema Sharma on 11/7/19.
//  Copyright © 2019 Seema Sharma. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    var post: Posts? {
        didSet {
            self.avatarImageView.loadImageUsing(urlString: post?.imageUrl ?? "")
            self.titleLabel.text = post?.title
            self.postBody.text = post?.body
            if let postDate = post?.date {
                self.postDate.text = postDate.getFormattedDate() ?? ""
            }
        }
    }
    
    var postComment: Comment? {
        didSet {
            self.avatarImageView.loadImageUsing(urlString: postComment?.avatarUrl ?? "")
            self.titleLabel.text = postComment?.userName
            self.postBody.text = postComment?.body
            if let postDate = postComment?.date {
                self.postDate.text = postDate.getFormattedDate() ?? ""
            }
        }
    }
    
    override func prepareForReuse() {
        self.avatarImageView.image = nil
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
