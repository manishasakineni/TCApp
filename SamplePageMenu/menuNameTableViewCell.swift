//
//  menuNameTableViewCell.swift
//  SamplePageMenu
//
//  Created by Manoj on 09/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class menuNameTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var menuNameImg: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//MARK: -  View Border color
     
        menuNameImg.layer.cornerRadius = 3
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
