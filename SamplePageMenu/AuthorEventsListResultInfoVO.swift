//
//  AuthorEventsListResultInfoVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 16/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class AuthorEventsListResultInfoVO: Mappable {
    
    //MARK:-  Declaration of AuthorEventsListResultInfoVO
    

    
    
    var id : Int?
    var title : String?
    var startDate : String?
    var endDate : String?
    var churchId : Int?
    var churchName : String?
    
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var eventImage : String?
    
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    
    
    
    //MARK:-  initialization of AuthorEventsListResultInfoVO
    
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?,churchName : String?,fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        self.churchName = churchName
        
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.eventImage = eventImage
        
        
        
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

        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        eventImage <- map["eventImage"]
        
        
        
    }
    
    
}
