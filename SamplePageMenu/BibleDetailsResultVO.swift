//
//  BibleDetailsResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class BibleDetailsResultVO: Mappable {
    
    
   //MARK:-  Declaration of BibleDetailsResultVO
    
    var id : Int?
    var name : String?
    var url : String?
    
     //MARK:-  initialization of BibleDetailsResultVO
    
    init(id : Int?,name : String?,url : String?)
        
        
    {
        
        
        self.id = id
        self.name = name
        self.url = url
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        
    }
    
    
}
