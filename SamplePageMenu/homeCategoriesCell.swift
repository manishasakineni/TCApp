//
//  homeTableViewCell.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit

class homeCategoriesCell: UITableViewCell {
    
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    

    @IBOutlet weak var categorieName: UILabel!
    
     //MARK: - Color
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        

        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
