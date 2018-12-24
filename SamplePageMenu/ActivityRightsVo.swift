//
//  ActivityRightsVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 05/09/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

//        "activityRights":[
//        {
//        "id": 8,
//        "name": "Can Manage Churches",
//        "desc": "Can Manage Churches",
//        "isActive": true,
//        "createdByUserId": 13,
//        "createdDate": "2018-03-09T02:00:31.27",
//        "updatedByUserId": 13,
//        "updatedDate": "2018-03-09T02:00:31.27"
//        }

import Foundation

class ActivityRightsVo: Mappable {
    
    var id: Int?
    var name: String?
    var desc: String?
    var isActive: Bool?
    var createdByUserId: Int?
    var createdDate: String?
    var updatedByUserId: Int?
    var updatedDate: String?
    
    init(id: Int?,
    name: String?,
    desc: String,
    isActive: Bool?,
    createdByUserId: Int?,
    createdDate: String?,
    updatedByUserId: Int?,
    updatedDate: String?) {
        
        self.id = id
        self.name = name
        self.desc = desc
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
        name <- map["name"]
        desc <- map["desc"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
       
    }
    
    
    
}
