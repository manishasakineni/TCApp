//
//  homeCollectionViewCell.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit

class homeCategoriesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mediaTypeLabel: UILabel!
    
    @IBOutlet weak var collectionImgView: UIImageView!
    
    @IBOutlet weak var viewOutLet: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewOutLet.layer.borderWidth = 2
        viewOutLet.layer.cornerRadius = 5.0
        viewOutLet.layer.borderColor = UIColor(red: 210.0/255.0, green: 231.0/255.0, blue: 242.0/255.0, alpha: 1.0).cgColor
        
    }

}
