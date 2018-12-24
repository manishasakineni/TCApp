//
//  IsLikeIsDislikeVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 12/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class IsLikeIsDislikeVO: Mappable {
    
    //MARK:-  Declaration of IsLikeIsDislikeVO
    
    
    var like    : Int?
    var disLike : Int?
    
    
    //MARK:-  initialization of IsLikeIsDislikeVO
    
    
    init(like : Int?, disLike : Int?) {
        
        self.like = like
        self.disLike = disLike
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        like <- map["like"]
        disLike <- map["disLike"]
        
        
    }
}
