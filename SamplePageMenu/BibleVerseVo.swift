//
//  BibleVerseVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleVerseVo: Mappable {
    
    
    //MARK:-  Declaration of BibleVerseVo
    
    
    var Verse: [BibleResultVo]?
   
      //MARK:-  initialization of BibleVerseVo
    
    
    init(Verse: [BibleResultVo]?) {
        
        self.Verse = Verse
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Verse <- map["Verse"]
        
        
    }
}
