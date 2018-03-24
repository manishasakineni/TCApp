//
//  CommentsCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var commentCountLab: UILabel!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var commentTexView: UITextView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sendBtn.tintColor = Utilities.appColor
        
        commentTexView.autocorrectionType = .no
        
       // backGroundView.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.50)
       // commentTexView.text = "Add a public comment..."
        commentTexView.textColor = UIColor.lightGray
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
