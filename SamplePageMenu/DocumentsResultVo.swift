//
//  DocumentsResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/15/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class DocumentsResultVo: Mappable {
    
    //MARK:-  Declaration of DocumentsResultVo
    
    var id : Int?
    var title : String?
    var desc : String?
    var categoryId : Int?
    var embededUrl : String?
    var mediaTypeId : Int?
    var postTypeId : Int?
    var userId : Int?
    var churchId : Int?
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var postImage : String?
    var mediaType : String?
    var postType : String?
    var categoryName : String?
    var createdByUser : String?
    var updatedByUser : String?
    
    
    //MARK:-  initialization of DocumentsResultVo
    
    
    init(id : Int?,title : String?,desc : String?,categoryId : Int?,embededUrl : String?,mediaTypeId : Int?,postTypeId : Int?,userId : Int?,churchId : Int?,fileName : String?,fileLocation : String?,fileExtention : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?,postImage : String?,mediaType : String?,postType : String?,categoryName : String?,createdByUser : String?,updatedByUser : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.desc = desc
        self.categoryId = categoryId
        self.embededUrl = embededUrl
        self.mediaTypeId = mediaTypeId
        self.postTypeId = postTypeId
        self.userId = userId
        self.churchId = churchId
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        self.postImage = postImage
        self.mediaType = mediaType
        self.postType = postType
        self.categoryName = categoryName
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        desc <- map["desc"]
        categoryId <- map["categoryId"]
        embededUrl <- map["embededUrl"]
        mediaTypeId <- map["mediaTypeId"]
        postTypeId <- map["postTypeId"]
        userId <- map["userId"]
        churchId <- map["churchId"]
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        
        
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        postImage <- map["postImage"]
        mediaType <- map["mediaType"]
        postType <- map["postType"]
        categoryName <- map["categoryName"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        
        
        
    }
    
    
}
