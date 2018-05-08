//
//  PostByEventImageVO.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class PostByEventImageVO: Mappable {
    
    var images:[PostByEventIdResultInfoVO]?
    
     var videos:[Array<Any>]?
     var audios:[Array<Any>]?
     var documents:[Array<Any>]?
    
    init(images:[PostByEventIdResultInfoVO]?, videos:[Array<Any>]?, audios:[Array<Any>]?, documents:[Array<Any>]?) {
        
        self.images = images
        self.videos = videos
         self.audios = audios
         self.documents = documents
        
        
    }
    
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        
        images <- map["images"]
        
         videos <- map["videos"]
         audios <- map["audios"]
         documents <- map["documents"]
        
    }
}
