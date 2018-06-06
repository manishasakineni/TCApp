//
//  CountryInfoResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 05/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class CountryInfoResultVO: Mappable {
    
   
    
//    "id": 1,
//    "code": "IN",
//    "name": "India",
//    "isActive": true,
//    "createdByUserId": 2,
//    "createdDate": "2018-01-30T19:37:22.663",
//    "updatedByUserId": 2,
//    "updatedDate": "2018-01-30T19:37:22.663"

    var id : Int?
   
    var code : String?
    var name : String?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    
    
    init(id: Int?,code : String?,name : String?,isActive :Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        
        self.code = code
        self.name = name
        
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
       
        code <- map["code"]
        name <- map["name"]
        
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
        
    }
    
    
}
