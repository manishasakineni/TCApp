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
        
        resetPasswordTF.clearsOnBeginEditing = false
        
        resetPasswordTF.clearsOnInsertion = false
    
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

class resetPasswordTF: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
}


