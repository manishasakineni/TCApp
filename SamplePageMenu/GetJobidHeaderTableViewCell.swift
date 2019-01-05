//
//  GetJobidHeaderTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetJobidHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var applyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        applyButton.layer.cornerRadius = 6.0
    }
}
