//
//  AuthorEventsListResultInfoVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 16/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class EventDetailsListResultVO: Mappable {
    
   
   //MARK:-  Declaration of EventDetailsListResultVO
    
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
    var isLike : Int?
    var isDisLike : Int?
    var likeCount : Int?
    var disLikeCount : Int?
    var commentCount : Int?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    

   //MARK:-  initialization of EventDetailsListResultVO
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?,churchName : String?, registrationNumber : String?, contactNumber : String?, fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?, isLike : Int?, isDisLike : Int?, likeCount : Int?, disLikeCount : Int?, commentCount : Int?, isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        self.churchName = churchName
        self.registrationNumber = registrationNumber
        self.contactNumber = contactNumber
        self.isLike = isLike
        self.isDisLike = isDisLike
        self.likeCount = likeCount
        self.disLikeCount = disLikeCount
        self.commentCount = commentCount
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
        isLike <- map["isLike"]
        isDisLike <- map["isDisLike"]
        likeCount <- map["likeCount"]
        disLikeCount <- map["disLikeCount"]
        commentCount <- map["commentCount"]
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
