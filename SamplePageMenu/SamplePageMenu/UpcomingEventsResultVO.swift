//
//  UpcomingEventsResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 09/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class UpcomingEventsResultVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
//    
//    
//    {
//    "id": 56,
//    "title": "God Always With You",
//    "startDate": "2018-03-09T12:56:33.61",
//    "endDate": "2018-03-10T18:56:33.61",
//    "churchId": 3,
//    "churchName": "Peace Church",
//    "registrationNumber": "Reg002",
//    "contactNumber": "9875642315",
//    "fileLocation": "2018\\03\\09\\Event",
//    "fileName": "20180309015733949",
//    "fileExtention": ".jpg",
//    "eventImage": "http://192.168.1.101/TeluguChurchesRepository/FileRepository/2018\\03\\09\\Event\\20180309015733949.jpg",
//    "isActive": true,
//    "createdByUserId": 8,
//    "createdDate": "2018-03-09T12:56:33.61",
//    "updatedByUserId": 8,
//    "updatedDate": "2018-03-09T12:56:33.61"
//    },
    
    
    var id : Int?
    var title : String?
    var startDate : String?
    var endDate : String?
    var churchId : Int?
    var churchName : String?
    var registrationNumber : String?
    var contactNumber : String?
    
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var eventImage : String?

    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?,churchName : String?,registrationNumber : String?,contactNumber : String?,fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        self.churchName = churchName
        self.registrationNumber = registrationNumber
        self.contactNumber = contactNumber
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
        registrationNumber <- map["registrationNumber"]
        contactNumber <- map["contactNumber"]
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
