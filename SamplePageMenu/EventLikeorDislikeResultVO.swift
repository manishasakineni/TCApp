//
//  EventLikeorDislikeResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class EventLikeorDislikeResultVO: Mappable {
    
    //MARK:-  Declaration of EventLikeorDislikeResultVO
    
    var eventId : Int?
    var userId : Int?
    var like : Bool?
    var disLike : Bool?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(eventId : Int?, userId : Int?, like : Bool?, disLike : Bool?) {
        
        self.eventId = eventId
        self.userId = userId
        self.like = like
        self.disLike = disLike
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventId <- map["eventId"]
        userId <- map["userId"]
        like <- map["like"]
        disLike <- map["disLike"]
      
        
    }
}
