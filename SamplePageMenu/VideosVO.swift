//
//  VideosVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class VideosVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
    var Id : Int?
    var ChurchId : Int?
    var ChurchName : String?
    var EmbedLink : String?
   
    
    //MARK:-  initialization of VideosVO
    
    
    init(Id:Int?, ChurchId:Int?,ChurchName:String?, EmbedLink:String?) {
        
        self.Id = Id
        self.ChurchId = ChurchId
        self.ChurchName = ChurchName
        self.EmbedLink = EmbedLink
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["Id"]
        ChurchId <- map["ChurchId"]
        ChurchName <- map["ChurchName"]
        EmbedLink <- map["EmbedLink"]
       
    }
}
