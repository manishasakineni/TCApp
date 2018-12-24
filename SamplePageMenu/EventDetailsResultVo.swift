//
//  EventDetailsResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventDetailsResultVo: Mappable {
    
   //MARK:-  Declaration of EventDetailsResultVo
    
    var eventDetails : [EventDetailsListResultVO]?
    var commentDetails : [EventCommentsVO]?
    
    
    //MARK:-  initialization of EventDetailsResultVo
    
    
    init(eventDetails : [EventDetailsListResultVO]?, commentDetails : [EventCommentsVO]?) {
        
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
