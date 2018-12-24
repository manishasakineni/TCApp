// 
//  NullNotificationCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 11/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class NullNotificationCell: UITableViewCell {
    
    
    
    @IBOutlet weak var answerTitlelabel: UILabel!
    
    @IBOutlet weak var quetionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        quetionLabel.numberOfLines = 0
        
        answerTitlelabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
