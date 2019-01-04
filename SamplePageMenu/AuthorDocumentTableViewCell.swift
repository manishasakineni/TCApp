//
//  AuthorDocumentTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 12/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AuthorDocumentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var documentView: UIView!
    @IBOutlet weak var documentlbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        documentView.layer.borderWidth = 2
        documentView.layer.cornerRadius = 5.0
        documentView.layer.borderColor = UIColor(red: 210.0/255.0, green: 231.0/255.0, blue: 242.0/255.0, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
