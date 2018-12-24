//
//  GetAllItemsTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetAllItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var allitemsImage: UIImageView!
    
    
    @IBOutlet weak var allitemsLabel: UILabel!
    
    @IBOutlet weak var allitemsDescLabel: UILabel!

    @IBOutlet weak var allitemsauthorLabel: UILabel!
    
    
    @IBOutlet weak var allitemsPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
