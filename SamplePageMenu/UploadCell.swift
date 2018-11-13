// 
//  UploadCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 11/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class UploadCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageDoc: UIImageView!
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
              
    }
}
