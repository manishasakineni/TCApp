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
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var infoContactNumber: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var churchName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var eventStart: UILabel!
    
    @IBOutlet weak var eventEndDate: UILabel!
  //  @IBOutlet weak var registrationNumber: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
     //MARK: - Color
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
