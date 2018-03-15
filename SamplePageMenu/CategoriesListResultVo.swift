//
//  CategoriesListResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/15/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class CategoriesListResultVo: Mappable {
    
    
    var images : [ImagesResultVo]?
    var videos : [VideoResultVo]?
    var audios : [audioRessultVo]?
    var documents : [DocumentsResultVo]?
   
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(images : [ImagesResultVo]?,videos : [VideoResultVo]?, audios : [audioRessultVo]?, documents : [DocumentsResultVo]?) {
        
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
