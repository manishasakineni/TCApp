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
    
    
    @IBOutlet weak var replayCountLbl: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    @IBOutlet weak var buttonImgOutLet: UIButton!
    
    @IBOutlet weak var readMoreBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var usersNameLbl: UILabel!
    
    @IBOutlet weak var usersLikeBtn: UIButton!
    
    @IBOutlet weak var usersLikeCoubtLbl: UILabel!
    
    @IBOutlet weak var usersDislikeBtn: UIButton!
    
    @IBOutlet weak var usersDislikeCoubtLbl: UILabel!
    
    @IBOutlet weak var replyCommentBtn: UIButton!
    
    @IBOutlet weak var viewCommentsBtn: UIButton!
    
    @IBOutlet weak var viewCommentsBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var editCommentBn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        usersImageView.layer.borderWidth = 0.50
        editCommentBn.isHidden = true
        usersImageView.layer.masksToBounds = false
        usersImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        usersImageView.layer.cornerRadius = usersImageView.frame.height/2
        usersImageView.clipsToBounds = true
        //viewCommentsBtn.setTitle("View Replies".localize(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
