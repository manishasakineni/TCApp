//
//  ConformButtonPassWordCell.swift
//  Telugu Churches
//
//  Created by Mac OS on 30/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ConformButtonPassWordCell: UITableViewCell {
    
    
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
     //MARK: - Color

    override func awakeFromNib() {
        
        confirmBtn.setTitle("Confirm".localize(), for: .normal)
        cancelBtn.setTitle("Cancel".localize(), for: .normal)

        
        confirmBtn.tintColor = UIColor.white
        cancelBtn.tintColor = UIColor.white
        
        confirmBtn.layer.borderWidth = 1.0
        confirmBtn.layer.borderColor = UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        confirmBtn.layer.backgroundColor = UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        confirmBtn.layer.cornerRadius = 3.0
        
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        cancelBtn.layer.backgroundColor = UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        cancelBtn.layer.cornerRadius = 3.0
        
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
