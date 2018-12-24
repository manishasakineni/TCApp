//
//  CategoriesResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class CategoriesResultVo: Mappable {
    
    //MARK:-  Declaration of CategoriesResultVo
    
    var id : Int?
    var categoryName : String?
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var categoryImage : String?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var createdByUser : String?
    var updatedByUserId : Int?
    var updatedByUser : String?
    var updatedDate : String?
    
    
    
    //MARK:-  initialization of CategoriesResultVo
    
    
    init(id : Int?,categoryName : String?,fileLocation : String?,categoryImage : String?,fileName : String?,fileExtention : String?,createdByUser : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?, updatedByUser:String?)
{
        
        self.id = id
        self.categoryName = categoryName
        self.categoryImage = categoryImage
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
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
        categoryName <- map["categoryName"]
        categoryImage <- map["categoryImage"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
        
    }
    
    
}
