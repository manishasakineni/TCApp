//
//  getNotificationCount.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 10/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class getNotificationCount: Mappable {
    
    
    //MARK:-  Declaration of GetProfileResultInfoVO
    
    var notificationsList: [getNotificationVO]?
    var unreadCount: Int?

    //MARK:-  initialization of GetProfileResultInfoVO
    
    init(notificationsList : [getNotificationVO]?, unreadCount: Int?) {
        self.notificationsList = notificationsList
        self.unreadCount = unreadCount
  
        
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        notificationsList <- map["notificationsList"]
        unreadCount <- map["unreadCount"]
    }
}
