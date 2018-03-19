//
//  menuTableViewCell.swift
//  SamplePageMenu
//
//  Created by Manoj on 09/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class menuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var progileImageView: UIImageView!
    @IBOutlet weak var menuTableViewLabel: UILabel!
    
    
    @IBOutlet weak var backGroundView: UIView!
    
    
    @IBOutlet weak var cameraOutLet: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        
//        backGroundView.layer.cornerRadius = 3.0
//        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
//        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        backGroundView.layer.shadowOpacity = 0.6
//        backGroundView.layer.shadowRadius = 2.0
//        
        
        
        progileImageView.layer.borderWidth = 1
        progileImageView.layer.masksToBounds = false
       // menuImgView.layer.borderColor = UIColor.black.cgColor
        progileImageView.layer.cornerRadius = progileImageView.frame.height/2
        progileImageView.clipsToBounds = true
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
