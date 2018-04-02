//
//  LikeDislikeCountVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 02/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class LikeDislikeCountVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
    var likeCount    : Int?
    var dislikeCount : Int?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(likeCount : Int?, dislikeCount : Int?) {
        
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
