//
//  BibleVerseTableViewCell.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 22/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleVerseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var verseLabel: UILabel!
    
    @IBOutlet weak var shareBrn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
