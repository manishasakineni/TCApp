//
//  BibleResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleResultVo: Mappable {
    
    
    //MARK:-  Declaration of BibleBookVo
    
    var Verseid: String?
    var Verse: String?
    
    init(Verse: String?, Verseid: String?) {
        
        self.Verse = Verse
        
        self.Verseid = Verseid
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Verse <- map["Verse"]
        
        Verseid <- map["Verseid"]
        
        
    }
}
