//
//  AuthorImageTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 12/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AuthorImageTableViewCell: UITableViewCell {

    @IBOutlet weak var authorImageView: UIImageView!
    
    
    @IBOutlet weak var imageLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
