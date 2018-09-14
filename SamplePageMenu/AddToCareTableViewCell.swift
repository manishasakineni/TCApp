//
//  AddToCareTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 17/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddToCareTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var addToCartImage: UIImageView!
    
    @IBOutlet weak var addToCartNameLbl: UILabel!
    
//    @IBOutlet weak var addToCartQuantityLbl: UILabel!
    
    @IBOutlet weak var addToCartAuthorLbl: UILabel!
    
    
    @IBOutlet weak var addToCartPriceLbl: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var quantityField: UITextField!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        quantityField.delegate = self
        
        updateBtn.isHidden = true
        
        quantityField.keyboardType = .numberPad
        
        updateBtn.layer.cornerRadius = 6
//        updateBtn.layer.borderColor = UIColor.white.cgColor
//        updateBtn.layer.borderWidth = 1
        
        
//        quantityField.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -  Text field delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        updateBtn.isHidden = false
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateBtn.isHidden = true
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        
        updateBtn.isHidden = false
        
        
    }
    
    //MARK:- Button
    func doneClick() {
        quantityField.resignFirstResponder()
        
    }
    func cancelClick() {
        quantityField.resignFirstResponder()
    }
}
