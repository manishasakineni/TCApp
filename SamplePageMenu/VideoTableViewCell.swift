//
//  VideoTableViewCell.swift
//  YouTubePlayerNew
//
//  Created by Mac OS on 08/01/18.
//  Copyright © 2018 tpcg. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class VideoTableViewCell: UITableViewCell{

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var IdLabel: UILabel!

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
