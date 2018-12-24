//
//  InfoHeaderCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/1/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class InfoHeaderCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var subscribeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
