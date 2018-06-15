//
//  NotificationResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 15/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class NotificationResultVO: Mappable {
    
  
    
    
    var id : Int?
    var name : String?
    var desc : String?
    var htmlDesc : String?
    var isRead : Bool?
    var churchId : Int?
    var authorId : Int?
    var eventId : Int?
    var postId : Int?
    var jobId : Int?
    var notificationTypeId : Int?
    var createdByUserId : Int?
    
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
   
    
    init(id: Int?,name : String?,desc : String?, htmlDesc : String?, isRead : Bool?, churchId : Int?, authorId : Int?, eventId : Int?, postId : Int?, jobId : Int?,notificationTypeId : Int?, createdByUserId : Int?, createdDate : String?, updatedByUserId : Int?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.name = name
        self.desc = desc
        self.htmlDesc = htmlDesc
        self.isRead = isRead
        self.churchId = churchId
        self.authorId = authorId
        self.eventId = eventId
        self.postId = postId
        self.jobId = jobId
        self.notificationTypeId = notificationTypeId
       
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        

        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        desc <- map["desc"]
        htmlDesc <- map["htmlDesc"]
        isRead <- map["isRead"]
        churchId <- map["churchId"]
        authorId <- map["authorId"]
        eventId <- map["eventId"]
        postId <- map["postId"]
        jobId <- map["jobId"]
        notificationTypeId <- map["notificationTypeId"]
        
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        

        
    }
    
    
    
}
