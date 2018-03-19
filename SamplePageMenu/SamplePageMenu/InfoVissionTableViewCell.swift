//
//  InfoVissionTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 08/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class InfoVissionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vissionBackgroundView: UIView!
    
    
    @IBOutlet weak var vissionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
