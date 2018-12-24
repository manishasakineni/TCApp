// 
//  ResumeUploadCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 11/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ResumeUploadCell: UITableViewCell {
    
    
    
    @IBOutlet weak var uploadResumeBtn: UIButton!
    
    @IBOutlet weak var applayBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        uploadResumeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        uploadResumeBtn.layer.borderWidth = 1
        uploadResumeBtn.layer.masksToBounds = false
        uploadResumeBtn.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        uploadResumeBtn.layer.cornerRadius = 6.0
        uploadResumeBtn.clipsToBounds = true
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
