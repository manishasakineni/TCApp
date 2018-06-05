//
//  CountryInfoResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 05/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class CountryInfoResultVO: Mappable {
    
    
    var id : Int?
    var mandalId : Int?
    var code : String?
    var name : String?
    var pinCode : Int?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    
    
    init(id: Int?,mandalId: Int?,code : String?,name : String?, pinCode : Int?,isActive :Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.mandalId = mandalId
        self.code = code
        self.name = name
        self.pinCode = pinCode
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
        mandalId <- map["mandalId"]
        code <- map["code"]
        name <- map["name"]
        pinCode <- map["pinCode"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
        
    }
    
    
}
