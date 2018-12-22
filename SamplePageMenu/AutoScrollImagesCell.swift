//
//  AutoScrollImagesCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 09/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AutoScrollImagesCell: UITableViewCell {
    
    
    @IBOutlet weak var upcomingEventsTitle: UILabel!
    @IBOutlet weak var autoScrollCollectionView: UICollectionView!
    
//MARK: -  variable declaration

    
    var lastXAxis = Int()
    var contentOffset = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cellSize = CGSize(width:200, height:100)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        autoScrollCollectionView.setCollectionViewLayout(layout, animated: true)
        
        autoScrollCollectionView.reloadData()
        
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//MARK: -  scroll ToNextCell 
   
    func scrollToNextCell(){
        
        let cellSize = CGSize(width:self.contentView.frame.width + 100, height:self.contentView.frame.height)
        
        print("cellSize:",cellSize)
        
        
        
        self.contentOffset = Int(self.autoScrollCollectionView.contentOffset.x + 100)
        
        let cellWidth = Int(self.contentOffset)
        
        
        print("",self.contentOffset)
        
        
       
        self.autoScrollCollectionView.scrollRectToVisible(CGRect(x:self.contentOffset + cellWidth + 100 , y:0, width:cellWidth + 100 , height:Int(cellSize.height)), animated: true)
        
        self.contentOffset = Int(self.contentOffset + Int(cellSize.width))
        
        print("contentOffset",self.contentOffset + cellWidth,cellSize.width + 100)
        
        
        
        
    }
    
}
