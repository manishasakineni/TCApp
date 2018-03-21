//
//  BibleChapterVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleChapterVo: Mappable {
    
    
    //MARK:-  Declaration of BibleBookVo
    
    
    var Chapter: [BibleVerseVo]?
    
    init(Chapter: [BibleVerseVo]?) {
        
        self.Chapter = Chapter
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Chapter <- map["Chapter"]
        
        
    }
}
