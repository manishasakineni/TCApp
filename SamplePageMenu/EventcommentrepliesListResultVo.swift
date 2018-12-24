//
//  EventcommentrepliesListResultVo.swift
//  Telugu Churches
//
//  Created by Manoj on 13/07/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventcommentrepliesListResultVo: Mappable {
    
    
   //MARK:-  Declaration of EventcommentrepliesListResultVo
    
    var id : Int?
    var eventId : Int?
    var comment : String?
    var parentCommentId : Int?
    var replyCount : Int?
    var userId : Int?
    var commentByUser : String?
    var userImage : String?
    
    //MARK:-  initialization of EventcommentrepliesListResultVo
    
    init(id: Int?,eventId : Int?,comment : String?,replyCount : Int?, parentCommentId : Int?, userId : Int?, commentByUser : String?, userImage : String?)
        
        
    {
        
        
        self.id = id
        self.eventId = eventId
        self.comment = comment
        self.parentCommentId = parentCommentId
        self.userId = userId
        self.commentByUser = commentByUser
        self.userImage = userImage
        self.replyCount = replyCount
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        eventId <- map["eventId"]
        comment <- map["comment"]
        parentCommentId <- map["parentCommentId"]
        userId <- map["userId"]
        commentByUser <- map["commentByUser"]
        userImage <- map["userImage"]
        replyCount <- map["replyCount"]
        
        
    }
    
    
    
}
