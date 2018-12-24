//
//  EventByIdInfoVo.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventByIdInfoVo: Mappable {
  
     //MARK:-  Declaration of EventByIdInfoVo
    
    var eventDetails:[EventByIdEventDetailsVO]?
    var commentDetails:[EventByIdCommentDetailsVO]?
   
    //MARK:-  initialization of EventByIdInfoVo
    
    init(eventDetails:[EventByIdEventDetailsVO]?, commentDetails:[EventByIdCommentDetailsVO]?) {
        
        self.eventDetails = eventDetails
        self.commentDetails = commentDetails
    }
    
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        
        eventDetails <- map["eventDetails"]
        commentDetails <- map["commentDetails"]
    }
}
