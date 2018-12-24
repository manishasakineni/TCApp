//
//  CategoriesListResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/15/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class CategoriesListResultVo: Mappable {
   
      //MARK:-  Declaration of CategoriesListResultVo
    
    
    var images : [ImagesResultVo]?
    var videos : [ImagesResultVo]?
    var audios : [ImagesResultVo]?
    var documents : [ImagesResultVo]?
   
    
    
    //MARK:-  initialization of CategoriesListResultVo
    
    
    init(images : [ImagesResultVo]?,videos : [ImagesResultVo]?, audios : [ImagesResultVo]?, documents : [ImagesResultVo]?) {
        
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
