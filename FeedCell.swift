//
//  FeedCell.swift
//  firebaseLearn
//
//  Created by abdullah on 19.02.2024.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
