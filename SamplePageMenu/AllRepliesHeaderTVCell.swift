//
//  AllRepliesHeaderTVCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 11/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AllRepliesHeaderTVCell: UITableViewCell {

    
    @IBOutlet weak var repliesCloseBtn: UIButton!
    
    @IBOutlet weak var allRepliesLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        allRepliesLbl.text = "All Replies".localize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
