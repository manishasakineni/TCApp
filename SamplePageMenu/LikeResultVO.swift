//
//  LikeResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 02/07/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class LikeResultVO: Mappable {
    
    //MARK:-  Declaration of LikeResultVO
    
    
    var likeCount    : Int?
    var dislikeCount : Int?
    var likeResult   : [LikeInfoVo]?
    
    //MARK:-  initialization of LikeResultVO
    
    
    init(likeCount : Int?, dislikeCount : Int?, likeResult : [LikeInfoVo]?) {
        
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
