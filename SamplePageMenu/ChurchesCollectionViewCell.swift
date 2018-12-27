//
//  ChurchesCollectionViewCell.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 26/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ChurchesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var churchImage: UIImageView!
    
    @IBOutlet weak var churchNameLbl: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var phNoLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var stateLbl: UILabel!
    
    
    @IBOutlet weak var districtLbl: UILabel!
    
    
    @IBOutlet weak var mandalLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
