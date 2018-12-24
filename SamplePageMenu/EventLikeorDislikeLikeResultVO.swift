//
//  EventLikeorDislikeLikeResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class EventLikeorDislikeLikeResultVO: Mappable {

     //MARK:-  Declaration of EventLikeorDislikeLikeResultVO
    
   var likeResult : [EventLikeorDislikeResultVO]?
   var likeCount : Int?
   var dislikeCount : Int?

//MARK:-  initialization of VideosVO


    init(likeResult : [EventLikeorDislikeResultVO]? , likeCount : Int?, dislikeCount : Int?) {
    
    self.likeCount = likeCount
    self.dislikeCount = dislikeCount
    
    
}

required init?(map: Map) {
    
}

func mapping(map: Map) {
    
    likeCount <- map["likeCount"]
    dislikeCount <- map["dislikeCount"]
    
}
}
