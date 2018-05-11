//
//  DeletePostCommentsListResultVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 5/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class DeletePostCommentsListResultVO: Mappable {
    
    
  

    
    var id : Int?
    var postId : Int?
    var description : String?
    
    var parentCommentId : Int?
    var userId : Int?
    
    
    init(id: Int?,postId: Int?,description: String?, parentCommentId: Int?, userId: Int?)
        
        
    {
        
        
        self.id = id
        self.postId = postId
        self.description = description
        self.parentCommentId = parentCommentId
        self.userId = userId
   
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        postId <- map["postId"]
        parentCommentId <- map["parentCommentId"]
        
        userId <- map["userId"]
       
        description <- map["description"]
        
        
    }
    
    
}


