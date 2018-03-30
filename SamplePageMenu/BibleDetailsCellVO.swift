//
//  BibleDetailsCellVO.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleDetailsCellVO: Mappable {
    
    
    
    
    
    
    var Verse : [BibleDetailsCellIResultVo]?
    
    //MARK:-  initialization of VideosVO
    
    
    init(Verse : [BibleDetailsCellIResultVo]?) {
        
        self.Verse = Verse
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Verse <- map["Verse"]
        
    }
}
