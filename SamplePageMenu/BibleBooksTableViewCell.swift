//
//  BibleBooksTableViewCell.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var bibleBookLabel: UILabel!
    
    @IBOutlet weak var chapterCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
