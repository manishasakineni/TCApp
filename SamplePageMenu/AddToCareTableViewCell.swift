//
//  AddToCareTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 17/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddToCareTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var addToCartImage: UIImageView!
    
    @IBOutlet weak var addToCartNameLbl: UILabel!
    
    @IBOutlet weak var addToCartQuantityLbl: UILabel!
    
    @IBOutlet weak var addToCartAuthorLbl: UILabel!
    
    
    @IBOutlet weak var addToCartPriceLbl: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
