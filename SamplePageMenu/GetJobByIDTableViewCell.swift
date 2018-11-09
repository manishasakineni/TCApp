//
//  GetJobByIDTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetJobByIDTableViewCell: UITableViewCell {

    
    @IBOutlet weak var jobIDNameLabel: UILabel!
    
    
    @IBOutlet weak var jobIDDetailsLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//     func viewDidLayoutSubviews() {
//        jobIDDetailsLabel.sizeToFit()
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
