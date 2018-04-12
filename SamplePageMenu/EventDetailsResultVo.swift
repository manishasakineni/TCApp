//
//  EventDetailsResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventDetailsResultVo: Mappable {
    
    
    var eventDetails : [EventDetailsListResultVO]?
    var commentDetails : Any?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(eventDetails : [EventDetailsListResultVO]?, commentDetails : Any?) {
        
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
