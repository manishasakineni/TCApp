//
//  homeTableViewCell.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit

class CategorieHomeCell: UITableViewCell {
    
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    
    
    @IBOutlet weak var moreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        

        

        
        moreButton.layer.cornerRadius = 1.0
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        
        
        
        
        moreButton.layer.cornerRadius = 3.0
        moreButton.layer.shadowColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        moreButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        moreButton.layer.shadowOpacity = 0.6
        moreButton.layer.shadowRadius = 2.0
        

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
