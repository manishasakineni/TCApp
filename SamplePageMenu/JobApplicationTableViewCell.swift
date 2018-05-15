//
//  JobApplicationTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class JobApplicationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var updateResumeBtnOutLet: UIButton!
    
    @IBOutlet weak var jobApplyBtnOutLet: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        jobApplyBtnOutLet.layer.cornerRadius = 6.0
     updateResumeBtnOutLet.layer.borderColor = UIColor(red: 206.0/255.0, green: 206.0/255.0, blue: 207.0/255.0, alpha: 1.0).cgColor
        
        
        // Configure the view for the selected state
    }
    
}
