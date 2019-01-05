//
//  GetAllJobDetailsTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 14/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetAllJobDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobtitleLabel: UILabel!
    @IBOutlet weak var qualificationLabel: UILabel!
    @IBOutlet weak var churchNameLabel: UILabel!
    @IBOutlet weak var cintactNumberLabel: UILabel!
    @IBOutlet weak var lastdateToApplyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
