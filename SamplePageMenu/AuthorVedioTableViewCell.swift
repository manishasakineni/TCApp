//
//  AuthorVedioTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 12/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AuthorVedioTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var authorVedioImage: UIImageView!
    
    
    
    @IBOutlet weak var authorVedioLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
