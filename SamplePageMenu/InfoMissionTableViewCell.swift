//
//  InfoMissionTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 08/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class InfoMissionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var missionBackgroundView: UIView!
    
    @IBOutlet weak var missionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
