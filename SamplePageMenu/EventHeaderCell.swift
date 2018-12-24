//
//  EventHeaderCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var eventDate: UILabel!
    
    
    @IBOutlet weak var eventName: UILabel!
    
    
    @IBOutlet weak var eventStartDate: UILabel!
    
    
    @IBOutlet weak var eventEndDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
