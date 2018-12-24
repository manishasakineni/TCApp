//
//  AllitemIdDetailsTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AllitemIdDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var isactiveLabel: UILabel!
    
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var sellerInfoLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
