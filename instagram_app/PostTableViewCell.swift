//
//  PostTableViewCell.swift
//  instagram_app
//
//  Created by Nicholas Rosas on 2/24/18.
//  Copyright © 2018 Nicholas Rosas. All rights reserved.
//

import UIKit
import ParseUI

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var postCaption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
