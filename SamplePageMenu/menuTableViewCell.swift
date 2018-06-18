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
    
    @IBOutlet weak var editBtnOutLet: UIButton!
    
    
 //MARK: - Color
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        progileImageView.layer.borderWidth = 1
        progileImageView.layer.masksToBounds = false
        progileImageView.layer.cornerRadius = progileImageView.frame.height/2
        progileImageView.clipsToBounds = true
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
