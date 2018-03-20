//
//  CommentsCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var commentCountLab: UITextView!
    
    
    @IBOutlet weak var commentTexView: UITextView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        commentTexView.autocorrectionType = .no
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
