//
//  AllItemIdListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class AllItemIdListResultVO: Mappable {
    
    
    
    var id : Int?
    var name : String?
    var desc : String?
    var itemTypeId : Int?
    var price : Int?
    var author : String?
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var isActive : Bool?
    
    
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var itemImage : String?
    var itemType : String?
    var createdByUser : String?
    var updatedByUser : String?
    
    
    
    init(id: Int?,name: String?,desc: String?, itemTypeId: Int?, price: Int?, author: String?, fileName: String?, fileLocation : String?, fileExtention : String?, isActive : Bool?,createdByUserId: Int?,createdDate: String?,updatedByUserId: Int?, updatedDate: String?, itemImage: String?, itemType: String?, createdByUser: String?, updatedByUser : String?)
        
        
    {
        
        
        self.id = id
        self.name = name
        self.desc = desc
        self.itemTypeId = itemTypeId
        self.price = price
        self.author = author
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.isActive = isActive
        
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        self.itemImage = itemImage
        self.itemType = itemType
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        desc <- map["desc"]
        itemTypeId <- map["itemTypeId"]
        price <- map["price"]
        author <- map["author"]
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        isActive <- map["isActive"]
        
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        itemImage <- map["itemImage"]
        itemType <- map["itemType"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        
        
        
        
    }
    
    
}

