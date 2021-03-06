//
//  ReplayCommentListResultVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 03/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class ReplayCommentListResultVO: Mappable {
    
   
   //MARK:-  Declaration of ReplayCommentListResultVO
    
    var id : Int?
    var postId : Int?
    var comment : String?
    
    var parentCommentId : Int?
    var userId : Int?
    var commentByUser : String?
    var userImage : String?
    var replyCount : Int?
   
    //MARK:-  initialization of ReplayCommentListResultVO
    
    init(id: Int?,postId: Int?,comment: String?, parentCommentId: Int?, userId: Int?, commentByUser: String?, userImage: String?, replyCount : Int?)
        
        
    {
        
        
        self.id = id
        self.postId = postId
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
        postId <- map["postId"]
        parentCommentId <- map["parentCommentId"]
        
        userId <- map["userId"]
        commentByUser <- map["commentByUser"]
        comment <- map["comment"]
        
        userImage <- map["userImage"]
        replyCount <- map["replyCount"]
    }
    
    
}

