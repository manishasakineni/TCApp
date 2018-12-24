//
//  Ownlabel.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 21/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class EZLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    
    func changeFontName()
    {
        self.font = UIFont(name: "Roboto", size: 3)
    }
}
