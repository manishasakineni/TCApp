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
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var activeTextField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        quantityField.delegate = self
        
        updateBtn.isHidden = true
        
        quantityField.keyboardType = .numberPad
        quantityField.maxLengthTextField = 2
        
        updateBtn.layer.cornerRadius = 6
//        updateBtn.layer.borderColor = UIColor.white.cgColor
//        updateBtn.layer.borderWidth = 1
        
        
//        quantityField.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        quantityField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -  Text field delegate methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
    
        if(textField == quantityField) {
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                if updatedText.count == 1 && updatedText == "0" {
                    return false
                }
            }
            
            let allowedCharacters = CharacterSet.decimalDigits
            let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
            return  unwantedStr.characters.count == 0
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text != "0" || textField.text != "" {
       // updateBtn.isHidden = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateBtn.isHidden = true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text != "0" || textField.text != "" {
          //  updateBtn.isHidden = false
        }
        
        else{
            
          updateBtn.isHidden = true
        }
        if(textField == quantityField) {
            
            if (quantityField != nil){
                
                let a:Double = Double(quantityField.text!) ?? 0
                let b:Double = Double(addToCartPriceLbl.text!)!
                
                totalPriceLbl.text = "\(a * b)"
            }
                
            else if (quantityField == nil){
                
                self.totalPriceLbl.text = "0"
            }
            
        }
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
