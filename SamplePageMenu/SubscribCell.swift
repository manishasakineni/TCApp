//
//  SubscribCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class SubscribCell: UITableViewCell {

    
    @IBOutlet weak var subscribImageView: UIImageView!
    
    
    @IBOutlet weak var subscribnameLbl: UILabel!
    
    @IBOutlet weak var subscribButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
