//
//  ChurchEventsListVO.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 25/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class ChurchEventsListVO: Mappable {
    
    
    //MARK:-  Declaration of ChurchEventsListVO
    
    var id : Int?
    var title : String?
    var startDate : String?
    var endDate : String?
    var churchId : Int?
    var authorId : Int?
    var churchName : String?
    
    var registrationNumber : String?
    var contactNumber : String?
    
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    var churchImage : String?
    
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    
    var description : String?
    var shortTitle : String?
    
    
    
    //MARK:-  initialization of ChurchEventsListVO
    
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?, authorId : Int?,churchName : String?, registrationNumber : String?, contactNumber : String?, fileLocation : String?,fileName : String?,fileExtention : String?,churchImage : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?, description : String?,shortTitle : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        self.authorId = authorId
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
        self.churchImage = churchImage
        self.description = description
        self.shortTitle = shortTitle
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        churchId <- map["churchId"]
        authorId <- map["authorId"]
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
        churchImage <- map["churchImage"]
        description <- map["description"]
        shortTitle <- map["shortTitle"]
        
        
        
    }

}
