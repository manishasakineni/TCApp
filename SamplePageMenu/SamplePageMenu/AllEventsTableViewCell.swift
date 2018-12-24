//
//  AllEventsTableViewCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AllEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var churchName: UILabel!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var endDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        backGroundView.layer.cornerRadius = 6.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
        
        eventImage.layer.borderWidth = 1
        eventImage.layer.masksToBounds = false
        eventImage.layer.borderColor = UIColor.white.cgColor
        eventImage.layer.cornerRadius = eventImage.frame.height/2
        eventImage.clipsToBounds = true

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
