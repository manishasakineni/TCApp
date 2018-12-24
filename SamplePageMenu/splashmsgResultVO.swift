//
//  splashmsgResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 25/07/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class splashmsgResultVO: Mappable {
    
    //MARK:-  Declaration of splashmsgResultVO
    
    var Id : Int?
    var splashMessage : String?
    var desc    : String?
    
    
    
    //MARK:-  initialization of splashmsgResultVO
    
    
    init(Id : Int?,splashMessage : String?,desc : String?)
        
        
    {
        
        
        self.Id = Id
        self.splashMessage = splashMessage
        self.desc = desc
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        splashMessage <- map["splashMessage"]
        desc <- map["desc"]
        
      
    }
    
    
}
