//
//  AddressTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 04/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    
    @IBOutlet weak var addresslineLbl: UILabel!
    
    @IBOutlet weak var statecountryLbl: UILabel!
    
    @IBOutlet weak var pincodeLbl: UILabel!
    
    @IBOutlet weak var mobileNoLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
