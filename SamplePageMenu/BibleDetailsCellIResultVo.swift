//
//  BibleDetailsCellIResultVo.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleDetailsCellIResultVo: Mappable {
    
    
    
    
    var Verseid : String?
    var Verse : String?
    
    
    
    init(Verseid : String?,Verse : String?)
        
        
    {
        
        
        self.Verseid = Verseid
        self.Verse = Verse
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Verseid <- map["Verseid"]
        Verse <- map["Verse"]
        
    }
    
    
}
