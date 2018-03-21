//
//  SubscribCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class SubscribCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var subscribImageView: UIImageView!
    
    
    @IBOutlet weak var subscribnameLbl: UILabel!
    
    @IBOutlet weak var subscribButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        subscribImageView.layer.borderWidth = 1
        subscribImageView.layer.masksToBounds = false
        subscribImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        subscribImageView.layer.cornerRadius = subscribImageView.frame.height/2
        subscribImageView.clipsToBounds = true
        
        
        backGroundView.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.50)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
