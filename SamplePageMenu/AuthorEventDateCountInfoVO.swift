//
//  AuthorEventDateCountInfoVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 16/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class AuthorEventDateCountInfoVO: Mappable {
    
    //MARK:-  Declaration of AuthorEventDateCountInfoVO
    
    
    
    var eventDate : String?
    var eventsCount : Int?
    var authorId : Int?
    var authorName : String?
    var churchId : Int?
    var churchName : String?
    var mobileNumber : String?
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var authorImage : String?
    
 
    
    
    //MARK:-  initialization of AuthorEventDateCountInfoVO
    
    
    init(eventsCount : Int?,churchName : String?,eventDate : String?,churchId : Int?, authorId : Int?, authorName : String?, mobileNumber : String?, fileLocation : String?,fileName : String?,fileExtention : String?,authorImage : String?)
        
        
    {
        
        
        self.eventsCount = eventsCount
        self.churchName = churchName
        self.eventDate = eventDate
        self.churchId = churchId
        self.churchName = churchName
        self.authorId = authorId
        self.authorName = authorName
        self.mobileNumber = mobileNumber
        
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.authorImage = authorImage
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventsCount <- map["eventsCount"]
        churchName <- map["churchName"]
 
        eventDate <- map["eventDate"]
        churchId <- map["churchId"]
      
        authorId <- map["authorId"]
        authorName <- map["authorName"]
        mobileNumber <- map["mobileNumber"]
        
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        authorImage <- map["authorImage"]
        
        
        
    }
    
    
}
