//
//  EventByIdEventDetailsVO.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class EventByIdEventDetailsVO: Mappable {
    
    
    
    
    //MARK:-  Declaration of EventByIdEventDetailsVO
    
    var id : Int?
    var title : String?
    var startDate : String?
    var endDate : String?
    var churchId : Int?
    
    var churchName : String?
    var registrationNumber : String?
    var contactNumber : String?
    var authorId : Any?
    var author_Name : Any?
    var mobileNumber : Any?
    var fileLocation : String?
    var fileName : String?
    var fileExtention : String?
    
    var eventImage : String?
    var isActive : Bool?
    var description : String?
    var isLike : Int?
    var isDisLike : Int?
    var likeCount : Int?
    var disLikeCount : Int?
    var commentCount : Int?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
   
    //MARK:-  initialization of EventByIdEventDetailsVO
    
    
    init(id : Int?,title : String?,startDate : String?,endDate : String?,churchId : Int?,churchName : String?,registrationNumber : String?,contactNumber : String?,authorId : Any?,author_Name : Any?,mobileNumber : Any?,fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?,isActive : Bool?,description : String?,isLike : Int?,isDisLike : Int?,likeCount : Int?,disLikeCount : Int?,commentCount : Int?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.churchId = churchId
        
        self.churchName = churchName
        self.registrationNumber = registrationNumber
        self.contactNumber = contactNumber
        self.authorId = authorId
        self.author_Name = author_Name
        self.mobileNumber = mobileNumber
        self.fileLocation = fileLocation
        
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.eventImage = eventImage
        self.isActive = isActive
        self.description = description
        self.isLike = isLike
        self.isDisLike = isDisLike
        self.likeCount = likeCount
        self.disLikeCount = disLikeCount
        self.commentCount = commentCount
        
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        
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
        authorId <- map["authorId"]
        author_Name <- map["author_Name"]
        mobileNumber <- map["mobileNumber"]
        fileLocation <- map["fileLocation"]
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        
        eventImage <- map["eventImage"]
        isActive <- map["isActive"]
        description <- map["description"]
        isLike <- map["isLike"]
        isDisLike <- map["isDisLike"]
        likeCount <- map["likeCount"]
        disLikeCount <- map["disLikeCount"]
        commentCount <- map["commentCount"]
        createdByUserId <- map["createdByUserId"]
        
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
        
        
    }
    
    
}



