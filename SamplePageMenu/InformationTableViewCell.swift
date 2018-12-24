//
//  InformationTableViewCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/22/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
   
    @IBOutlet weak var backGroundView: UIView!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var symbolLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoLabel.numberOfLines = 0
        
        addressLabel.numberOfLines = 0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
