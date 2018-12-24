//
//  PopOverTableViewCell.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 11/09/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        menuTitle.text = ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
