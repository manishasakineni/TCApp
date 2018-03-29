//
//  ChurchAuthorSubscriptionResultVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 29/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class ChurchAuthorSubscriptionResultVO: Mappable {

    
    var isSubscribed : Int?
    
    init(isSubscribed : Int?) {
        
        self.isSubscribed = isSubscribed
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        isSubscribed <- map["isSubscribed"]}

}