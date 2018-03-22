//
//  UsersCommentsTableViewCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class UsersCommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var usersImageView: UIImageView!
    

    @IBOutlet weak var usersCommentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        backGroundView.layer.borderWidth = 0.50
//        backGroundView.layer.borderColor = UIColor.black.cgColor

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
