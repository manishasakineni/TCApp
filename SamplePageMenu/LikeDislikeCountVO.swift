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
    var likeResult   : [IsLikeIsDislikeVO]?
    
    //MARK:-  initialization of VideosVO
    
    
    init(likeCount : Int?, dislikeCount : Int?, likeResult : [IsLikeIsDislikeVO]?) {
        
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
        self.likeResult = likeResult
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        likeCount <- map["likeCount"]
        dislikeCount <- map["dislikeCount"]
        likeResult  <- map["likeResult"]
        
    }
}
