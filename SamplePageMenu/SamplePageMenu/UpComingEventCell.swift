//
//  UpComingEventCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/7/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class UpComingEventCell: UITableViewCell {

    @IBOutlet weak var chuechName: UILabel!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventStart: UILabel!
    
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var registrationNumber: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventImage.layer.borderWidth = 1
        eventImage.layer.masksToBounds = false
        eventImage.layer.borderColor = UIColor.white.cgColor
        eventImage.layer.cornerRadius = eventImage.frame.height/2
        eventImage.clipsToBounds = true
//        
//        eventImage.layer.masksToBounds = false
//        eventImage.layer.cornerRadius = eventImage.frame.width/2
//        eventImage.layer.cornerRadius = 1.0
//        eventImage.layer.borderColor = UIColor.lightGray.cgColor
//        eventImage.clipsToBounds = true
//        eventImage.layer.shadowColor = UIColor.lightGray.cgColor
//        eventImage.layer.shadowOffset = CGSize(width: 0, height: 3)
//        eventImage.layer.shadowOpacity = 0.6
//        eventImage.layer.shadowRadius = 0.5
//
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
