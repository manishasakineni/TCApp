//
//  statecountryTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 05/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class statecountryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var stateTF: UITextField!
    
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var mobileNoTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
