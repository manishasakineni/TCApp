//
//  AdminMonthEventListCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/19/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AdminMonthEventListCell: UITableViewCell {

    @IBOutlet weak var churchName: UILabel!
    
    
    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventAddress: UILabel!
    
    
    @IBOutlet weak var toDate: UILabel!
    
    @IBOutlet weak var fromDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
