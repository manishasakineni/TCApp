//
//  GenderTableViewCell.swift
//  PageView_Naveen
//
//  Created by Nani Mac on 21/09/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class GenderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var maleUnCheckBtn: UIImageView!
    
    @IBOutlet weak var femaleUnCheck: UIImageView!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var saveBtnHeight: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    
    @IBOutlet weak var maleBtn: UIButton!
   
    
    @IBOutlet weak var femaleBtn: UIButton!
    
}
