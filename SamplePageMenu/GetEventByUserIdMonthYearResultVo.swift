//
//  GetEventByUserIdMonthYearResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/22/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class GetEventByUserIdMonthYearResultVo: Mappable {
    
    //MARK:-  Declaration of GetEventByUserIdMonthYearResultVo
    
    var eventDate : String?
    var eventsCount : Int?
    var churchId : Int?
    var churchName : String?
    var authorId : Int?
    var eventName : String?
    var contactNumber : String?
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var eventImage : String?
    
    
    //MARK:-  initialization of GetEventByUserIdMonthYearResultVo
    
    
    init(eventDate : String?,eventsCount : Int?,churchId : Int?, authorId : Int?, churchName : String?, eventName: String?, contactNumber : String?,  fileLocation : String?, fileName : String?, fileExtention : String?, eventImage : String?)
        
        
    {
        
  
        self.eventDate = eventDate
        self.eventsCount = eventsCount
        self.churchId = churchId
        self.authorId = authorId
        self.churchName = churchName
        self.eventName = eventName
        self.contactNumber = contactNumber
        self.fileLocation = fileLocation
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.eventImage = eventImage
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventDate <- map["eventDate"]
        eventsCount <- map["eventsCount"]
        churchId <- map["churchId"]
        authorId <- map["authorId"]
        churchName <- map["churchName"]
        eventName <- map["eventName"]
        contactNumber <- map["contactNumber"]
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        eventImage <- map["eventImage"]
        
        
    }
    
    
}
