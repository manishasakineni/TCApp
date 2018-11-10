//
//  NotificationTableViewCell.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 10/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var notificationNameLbl: UILabel!
    
    
    @IBOutlet weak var notificationDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
