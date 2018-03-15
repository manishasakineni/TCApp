//
//  AutoScrollImagesCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 09/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AutoScrollImagesCell: UITableViewCell {
    
    
    @IBOutlet weak var autoScrollCollectionView: UICollectionView!
    
    
    var lastXAxis = Int()
    var contentOffset = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(AutoScrollImagesCell.scrollToNextCell), userInfo: nil, repeats: true)
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func scrollToNextCell(){
        
        let cellSize = CGSize(width:self.contentView.frame.width, height:self.contentView.frame.height)
        
        print("cellSize:",cellSize)
        
        
        
        self.contentOffset = Int(self.autoScrollCollectionView.contentOffset.x)
        
        let cellWidth = Int(self.contentOffset)
        
//        if(self.contentOffset == 0)
//        {
//            self.autoScrollCollectionView.contentOffset = CGPoint.init(x: 0, y: 0)
//            
//        }
        
        print("",self.contentOffset)
        
        //scroll to next cell
        
       
        self.autoScrollCollectionView.scrollRectToVisible(CGRect(x:self.contentOffset + cellWidth , y:0, width:cellWidth , height:Int(cellSize.height)), animated: true)
        
        self.contentOffset = Int(self.contentOffset + Int(cellSize.width))
        
        print("contentOffset",self.contentOffset + cellWidth,cellSize.width)
        
        
       // self.lastXAxis = self.contentOffset
        
        
    }
    
}
