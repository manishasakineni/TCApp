//
//  EventCommentsVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class EventCommentsVO: Mappable {
    
 //MARK:-  Declaration of EventCommentsVO
    
    var id : Int?
    var eventId : Int?
    var comment : String?
    var parentCommentId : Int?
    var userId : Int?
    var commentByUser : String?
    var userImage : String?
    
    
    //MARK:-  initialization of EventCommentsVO
    
    
    init(id : Int?, eventId : Int?, comment : String?, parentCommentId : Int?, userId : Int?, commentByUser : String?, userImage : String?) {
        
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
        comment <- map["comment"]
        parentCommentId <- map["parentCommentId"]
        userId <- map["userId"]
        commentByUser <- map["commentByUser"]
        userImage <- map["userImage"]
        
        
        
    }
}
