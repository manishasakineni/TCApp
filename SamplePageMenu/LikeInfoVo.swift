//
//  LikeInfoVo.swift
//  Telugu Churches
//
//  Created by Manoj on 02/07/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class LikeInfoVo: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
    var like1    : Int?
    var disLike : Int?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(like1 : Int?, disLike : Int?) {
        
        self.like1 = like1
        self.disLike = disLike
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        like1 <- map["like1"]
        disLike <- map["disLike"]
        
        
    }
}
