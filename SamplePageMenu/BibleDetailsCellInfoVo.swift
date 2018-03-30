//
//  BibleDetailsCellInfoVo.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleDetailsCellInfoVo: Mappable {
    
    
    
    
    
    
    var Chapter : [BibleDetailsCellVO]?
    
    //MARK:-  initialization of VideosVO
    
    
    init(Chapter : [BibleDetailsCellVO]?) {
        
        self.Chapter = Chapter
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Chapter <- map["Chapter"]
        
    }
}
