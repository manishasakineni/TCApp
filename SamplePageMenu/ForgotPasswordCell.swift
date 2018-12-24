//
//  ForgotPasswordCell.swift
//  Telugu Churches
//
//  Created by Mac OS on 30/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import TextFieldEffects



class ForgotPasswordCell: UITableViewCell {

    @IBOutlet weak var resetPasswordTF: AkiraTextField!
    
    
    @IBOutlet weak var eyeButtonOutlet: UIButton!
    
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
       eyeButtonOutlet.isHidden = true

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        eyeButtonOutlet.isHidden = false
        
        return true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
