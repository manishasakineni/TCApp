//
//  EventInformationCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class EventInformationCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var eventType: UILabel!
    
    @IBOutlet weak var eventStartDateLabel: UILabel!
    
    
    @IBOutlet weak var eventEndDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
