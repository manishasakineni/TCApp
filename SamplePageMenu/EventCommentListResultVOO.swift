//
//  EventCommentListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 04/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventCommentListResultVOO: Mappable {
    
   //MARK:-  Declaration of EventCommentListResultVOO
    
    var id : Int?
    var eventId : Int?
    var comment : String?
    
    var parentCommentId : Int?
    var userId : Int?
    var commentByUser : String?
    var userImage : Any?
    
     //MARK:-  initialization of EventCommentListResultVOO
    
    init(id: Int?,eventId: Int?,comment: String?, parentCommentId: Int?, userId: Int?, commentByUser: String?, userImage: Any?)
        
        
    {
        
        
        self.id = id
        self.eventId = eventId
        self.comment = comment
        self.parentCommentId = parentCommentId
        self.userId = userId
        self.commentByUser = commentByUser
        self.userImage = userImage
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        eventId <- map["eventId"]
        parentCommentId <- map["parentCommentId"]
        
        userId <- map["userId"]
        commentByUser <- map["commentByUser"]
        comment <- map["comment"]
        
        userImage <- map["userImage"]
        
    }
    
    
}

