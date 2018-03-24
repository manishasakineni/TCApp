//
//  homeCollectionViewCell.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit

class CategorieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collectionImgView: UIImageView!
    
    @IBOutlet weak var viewOutLet: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        viewOutLet.layer.cornerRadius = 3.0
        viewOutLet.layer.shadowColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        viewOutLet.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewOutLet.layer.shadowOpacity = 0.6
        viewOutLet.layer.shadowRadius = 10.0
        
        viewOutLet.layer.cornerRadius = 5.0
        viewOutLet.layer.borderWidth = 1
//        viewOutLet.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor

        viewOutLet.layer.borderColor = Utilities.bordrColor
        
        collectionImgView.layer.cornerRadius = 3.0
        collectionImgView.layer.shadowColor = UIColor.lightGray.cgColor
        collectionImgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        collectionImgView.layer.shadowOpacity = 0.6
        collectionImgView.layer.shadowRadius = 0.5
        
//        collectionImgView.layer.cornerRadius = 5.0
//        collectionImgView.layer.borderWidth = 1
//        collectionImgView.layer.borderColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
//
//        
      
        // Initialization code
    }

}
