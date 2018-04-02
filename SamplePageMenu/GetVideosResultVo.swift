//
//  GetVideosResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 02/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class GetVideosResultVo: Mappable {
    
    var postDetails:[PostDetailsVO]?
    var commentDetails:[CommentDetailsVo]?
    
    init(postDetails:[PostDetailsVO]?, commentDetails:[CommentDetailsVo]?) {
        
        self.postDetails = postDetails
        self.commentDetails = commentDetails
    }
    
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
    
        postDetails <- map["postDetails"]
        commentDetails <- map["commentDetails"]
    }
}
