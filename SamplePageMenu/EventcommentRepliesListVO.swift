//
//  EventcommentRepliesListVO.swift
//  Telugu Churches
//
//  Created by Manoj on 13/07/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class EventcommentRepliesListVO: Mappable {
    
    var eventDetails:[EventCommRepliesVO]?
    var commentDetails:[EventcommentrepliesListResultVo]?
    var replyDetails:[EventcommentrepliesListResultVo]?
    init(eventDetails:[EventCommRepliesVO]?, commentDetails:[EventcommentrepliesListResultVo]?, replyDetails:[EventcommentrepliesListResultVo]?) {
        
        self.eventDetails = eventDetails
        self.commentDetails = commentDetails
        self.replyDetails = replyDetails
    }
    
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        replyDetails <- map["replyDetails"]
        eventDetails <- map["eventDetails"]
        commentDetails <- map["commentDetails"]
    }
}
