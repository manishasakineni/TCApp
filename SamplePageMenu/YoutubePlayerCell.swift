//
//  YoutubePlayerCell.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class YoutubePlayerCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var allOffersImageView: UIImageView!
    
    
    @IBOutlet weak var allOffersImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        // Initialization code

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
