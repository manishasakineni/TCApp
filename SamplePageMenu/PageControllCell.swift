//
//  PageControllCell.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class PageControllCell: UITableViewCell {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var pageingImageView: UIImageView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    var timer : Timer!
    var upDateCounter : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        upDateCounter = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PageControllCell.updateTimer), userInfo: nil, repeats: true)
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
        
        
        
        
      //  updateTimer()
        
        // Initialization code
    }

    
    internal func updateTimer(){
        
        if (upDateCounter <= 4) {
            
            pageController.currentPage = upDateCounter
            pageingImageView.image = UIImage(named: String(upDateCounter+1))
            upDateCounter = upDateCounter + 1
        }
        else{
            
            upDateCounter = 0
        }
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
