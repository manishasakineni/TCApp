//
//  AutoScrollCollectionViewCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 09/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AutoScrollCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var autoScrollImage: UIImageView!
    
    @IBOutlet weak var churchNameLabel: UILabel!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var mobileNoLabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var eventToLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
