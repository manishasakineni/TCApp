//
//  EventByIdCommentDetailsVO.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventByIdCommentDetailsVO: Mappable {
    
    //MARK:-  Declaration of EventByIdCommentDetailsVO
    
    var id : Int?
    var eventId : Int?
    var comment : String?
    
    var parentCommentId : Any?
    var userId : Int?
    var commentByUser : String?
    var userImage : String?
  
    //MARK:-  initialization of EventByIdCommentDetailsVO
    
    init(id: Int?,eventId: Int?,comment: String?, parentCommentId:Any?, userId: Int?, commentByUser: String?, userImage: String?)
        
        
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
        comment <- map["comment"]
        parentCommentId <- map["parentCommentId"]
        userId <- map["userId"]
        commentByUser <- map["commentByUser"]
        userImage <- map["userImage"]
    }
    
    
}
