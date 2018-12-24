//
//  SignUPTableViewCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 24/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import TextFieldEffects

class SignUPTableViewCell: UITableViewCell {
    
    
    
   
    @IBOutlet weak var registrationTextfield: AkiraTextField!

    @IBOutlet weak var eyeButtonOutlet: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
      //  registrationTextfield.autocorrectionType = .no
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
