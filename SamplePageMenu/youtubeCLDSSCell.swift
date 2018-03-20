//
//  youtubeCLDSSCell.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/20/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class youtubeCLDSSCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var videoTitleName: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var unlikeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        backGroundView.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.50)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



