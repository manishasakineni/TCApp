//
//  AuthorleventTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 29/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AuthorleventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var authornameLbl: UILabel!
    
    @IBOutlet weak var phnoLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
