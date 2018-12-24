//
//  AuthorEventDateCountInfoVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 16/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class AuthorEventDateCountInfoVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
 /*   "eventDate": "2018-03-09T00:00:00",
    "eventsCount": 3,
    "churchId": 3,
    "churchName": "Peace Church",
    "fileLocation": "2018\\03\\01\\Church",
    "fileName": "20180301034327001",
    "fileExtention": ".jpg",
    "eventImage": "http://192.168.1.121/TeluguChurchesRepository/FileRepository/2018\\03\\01\\Church\\20180301034327001.jpg"
    
 
 */
    
    var eventDate : String?
    var eventsCount : Int?

    
    var churchId : Int?
    var churchName : String?
    
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var eventImage : String?
    
 
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(eventsCount : Int?,churchName : String?,eventDate : String?,churchId : Int?,fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?)
        
        
    {
        
        
        self.eventsCount = eventsCount
        self.churchName = churchName
       
        self.eventDate = eventDate
        self.churchId = churchId
        self.churchName = churchName
    
        
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.eventImage = eventImage
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventsCount <- map["eventsCount"]
        churchName <- map["churchName"]
 
        eventDate <- map["eventDate"]
        churchId <- map["churchId"]
      
  
        
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        eventImage <- map["eventImage"]
        
        
        
    }
    
    
}
