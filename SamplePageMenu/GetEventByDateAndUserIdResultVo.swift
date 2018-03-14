//
//  GetEventByDateAndUserIdResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/23/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class GetEventByDateAndUserIdResultVo: Mappable {
    
    var eventId : Int?
    var eventTitle : String?
    var startDate : String?
    var endDate : String?
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(eventId : Int?,eventTitle : String?,startDate : String?,endDate : String?)
        
        
    {
        
        
        self.eventId = eventId
        self.eventTitle = eventTitle
        self.startDate = startDate
        self.endDate = endDate
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventId <- map["eventId"]
        eventTitle <- map["eventTitle"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        
        
        
    }
    
    
}
