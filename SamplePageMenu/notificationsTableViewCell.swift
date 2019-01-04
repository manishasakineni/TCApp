//
//  notificationsTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 15/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class notificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
