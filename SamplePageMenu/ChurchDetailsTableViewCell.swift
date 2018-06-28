//
//  ChurchDetailsTableViewCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import SDWebImage

class ChurchDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var churchImage: UIImageView!
    @IBOutlet weak var churchNameLbl: UILabel!
    
    
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var phNoLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var SubscribeBtn: UIButton!
    
    @IBOutlet weak var stateLbl: UILabel!
    
    
    @IBOutlet weak var districtLbl: UILabel!
    
    
    @IBOutlet weak var mandalLbl: UILabel!
    
     //MARK: - Color
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        churchImage.layer.borderWidth = 1
        churchImage.layer.masksToBounds = false
        
       
        churchImage.clipsToBounds = true
        
        SubscribeBtn.layer.cornerRadius = 1.0
        SubscribeBtn.layer.borderWidth = 0.5
        SubscribeBtn.layer.borderColor = UIColor.lightGray.cgColor
        SubscribeBtn.backgroundColor = Utilities.appColor
        
        
        
        
        SubscribeBtn.layer.cornerRadius = 3.0
        SubscribeBtn.layer.shadowColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        SubscribeBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        SubscribeBtn.layer.shadowOpacity = 0.6
        SubscribeBtn.layer.shadowRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
