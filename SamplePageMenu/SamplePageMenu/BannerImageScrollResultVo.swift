//
//  BannerImageScrollResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/8/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class BannerImageScrollResultVo: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    var id : Int?
    var bannerImage : String?
    var bannerName : String?
    var isActive : Bool?
    var lastUpdatedByUserId : Int?
    var lastUpdatedDate : String?
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(id : Int?,bannerImage : String?,bannerName : String?,isActive : Bool?,lastUpdatedByUserId : Int?,lastUpdatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.bannerImage = bannerImage
        self.bannerName = bannerName
        self.isActive = isActive
        self.lastUpdatedByUserId = lastUpdatedByUserId
        self.lastUpdatedDate = lastUpdatedDate
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        bannerImage <- map["bannerImage"]
        bannerName <- map["bannerName"]
        isActive <- map["isActive"]
        lastUpdatedByUserId <- map["lastUpdatedByUserId"]
        lastUpdatedDate <- map["lastUpdatedDate"]
        
        
    }
    
    
}
