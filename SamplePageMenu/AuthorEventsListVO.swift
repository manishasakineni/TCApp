//
//  AuthorEventsListVO.swift
//  Telugu Churches
//
//  Created by Arun Gattadi on 25/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class AuthorEventsListInfoVO: Mappable {
    
    //MARK:-  Declaration of AuthorEventsListResultInfoVO

    var id : Int?
    var title : String?
    var startDate : String?
    var endDate : String?
    var churchId : Int?
    var churchName : String?
    var authorId : Int?
    var authorName : String?
    var mobileNumber: String?
    
    
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var authorImage : String?
    
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var description : String?
    var eventShortTitle : String?
    var authorShortTitle : String?

    
    //MARK:-  initialization of AuthorEventsListResultInfoVO
    
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?,churchName : String?, authorId : Int?, authorName : String?, mobileNumber: String?, fileLocation : String?,fileName : String?,fileExtention : String?,authorImage : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?,description : String?, eventShortTitle : String?, authorShortTitle : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        self.churchName = churchName
        self.authorId = authorId
        self.authorName = authorName
        self.mobileNumber = mobileNumber
        
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.authorImage = authorImage
        self.description = description
        self.eventShortTitle = eventShortTitle
        self.authorShortTitle = authorShortTitle
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        churchId <- map["churchId"]
        churchName <- map["churchName"]
        authorId <- map["authorId"]
        authorName <- map["authorName"]
        mobileNumber <- map["mobileNumber"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        authorImage <- map["authorImage"]
        description <- map["description"]
        eventShortTitle <- map["eventShortTitle"]
        authorShortTitle <- map["authorShortTitle"]

    
        
        
        
    }
    
    
}
