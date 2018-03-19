//
//  TermsAndConditionCell.swift
//  OffersScreen
//
//  Created by Mac OS on 26/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class TermsAndConditionCell: UITableViewCell {

    @IBOutlet weak var transactNowButton: UIButton!
    @IBOutlet weak var tleLabel: UILabel!
    @IBOutlet weak var transactionStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
