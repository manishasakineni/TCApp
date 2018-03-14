//
//  InfoTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 20/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iDLabel: UILabel!
    
    
    @IBOutlet weak var valueLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
