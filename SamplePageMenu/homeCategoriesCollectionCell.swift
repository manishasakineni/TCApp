//
//  homeCollectionViewCell.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit

class homeCategoriesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collectionImgView: UIImageView!
    
    @IBOutlet weak var viewOutLet: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewOutLet.layer.cornerRadius = 5.0
        viewOutLet.layer.borderWidth = 1
        viewOutLet.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor

        // Initialization code
    }

}
