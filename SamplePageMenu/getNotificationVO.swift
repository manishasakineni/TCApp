//
//  getNotificationVO.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 10/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class getNotificationVO: Mappable {
    
    //MARK:-  Declaration of getNotificationVO

    var Id : Int?
    var name : String?
    var desc : String?
    var htmlDesc : String?
    var notificationDate : String?
    var churchId : Int?
    var authorId : Int?
    var eventId : Int?
    var postId : Int?
    var notificationTypeId : Int?
    var createdByUserId : Int?
    var createdBy : String?
    var createdDate : String?
    var notificationGeneratedOn : String?
    var isRead : Bool?

    
    
    
    //MARK:-  initialization of getNotificationVO
    
    
    init(Id:Int?, name : String?,desc : String?, htmlDesc : String?,notificationDate : String?,churchId : Int?,authorId : Int?,eventId : Int?,postId : Int?,notificationTypeId : Int?,CreatedByUserId : Int?,createdBy : String?,CreatedDate : String?,notificationGeneratedOn : String?, isRead : Bool?) {
        
        self.Id = Id
        self.name = name
        self.desc = desc
        self.htmlDesc = htmlDesc
        self.notificationDate = notificationDate
        self.churchId = churchId
        self.authorId = authorId
        self.eventId = eventId
        self.postId = postId
        self.notificationTypeId = notificationTypeId
        self.createdByUserId = CreatedByUserId
        self.createdBy = createdBy
        self.createdDate = CreatedDate
        self.notificationGeneratedOn = notificationGeneratedOn
        
        self.isRead = isRead
       
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        name <- map["name"]
        desc <- map["desc"]
        htmlDesc <- map["htmlDesc"]
        notificationDate <- map["notificationDate"]
        churchId <- map["churchId"]
        authorId <- map["authorId"]
        eventId <- map["eventId"]
        postId <- map["postId"]
        notificationTypeId <- map["notificationTypeId"]
        createdByUserId <- map["createdByUserId"]
        createdBy <- map["createdBy"]
        createdDate <- map["CreatedDate"]
        notificationGeneratedOn <- map["notificationGeneratedOn"]
        
        isRead <- map["isRead"]
    }
    
    
}
