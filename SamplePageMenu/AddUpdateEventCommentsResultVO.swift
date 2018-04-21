//
//  AddUpdateEventCommentsResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class AddUpdateEventCommentsResultVO: Mappable {
    
    var id : Int?
    var eventId : Int?
    var description : String?
    var parentCommentId : Int?
    var userId : Int?
    
    //MARK:-  initialization of VideosVO
    
    
    init(id : Int?, eventId : Int?, description : String?, parentCommentId : Int?, userId : Int?) {
        
        self.id = id
        self.eventId = eventId
        self.description = description
        self.parentCommentId = parentCommentId
        self.userId = userId
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        eventId <- map["eventId"]
        description <- map["description"]
        parentCommentId <- map["parentCommentId"]
        userId <- map["userId"]
    }
}