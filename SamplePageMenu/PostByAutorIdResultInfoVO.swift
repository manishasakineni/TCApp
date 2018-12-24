//
//  PostByAutorIdResultInfoVO.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class PostByAutorIdResultInfoVO: Mappable {
    
    
   //MARK:-  Declaration of PostByAutorIdResultInfoVO
    
    var id : Int?
    var title : String?
    var desc : String?
    var categoryId : Int?
    var embededUrl : String?
    var mediaTypeId : Int?
    var postTypeId : Int?
    var userId : Int?
    var postImage : String?
    var embedId : Any?
    var mediaType : String?
    var postType : String?
    var categoryName : String?
    var likeCount : Int?
    var disLikeCount : Int?
    var commentCount : Int?
    var viewCount : Any?
    var createdByUser : String?
    var updatedByUser : String?
    var postUpdatedDate : String?
    
     //MARK:-  initialization of PostByAutorIdResultInfoVO
    
    init(id: Int?,title: String?,desc: String?, categoryId:Int?, embededUrl: String?, mediaTypeId: Int?, postTypeId: Int?,userId: Int?,postImage: String?, embedId:Any?, mediaType: String?, postType: String?, categoryName: String?,likeCount: Int?,disLikeCount: Int?,commentCount: Int?, viewCount:Any?, createdByUser: String?, updatedByUser: String?, postUpdatedDate: String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.desc = desc
        self.categoryId = categoryId
        self.embededUrl = embededUrl
        self.mediaTypeId = mediaTypeId
        self.postTypeId = postTypeId
        self.userId = userId
        self.postImage = postImage
        self.embedId = embedId
        self.mediaType = mediaType
        self.postType = postType
        self.categoryName = categoryName
        self.likeCount = likeCount
        self.disLikeCount = disLikeCount
        self.commentCount = commentCount
        self.viewCount = viewCount
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        self.postUpdatedDate = postUpdatedDate
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        desc <- map["desc"]
        categoryId <- map["categoryId"]
        embededUrl <- map["embededUrl"]
        mediaTypeId <- map["mediaTypeId"]
        postTypeId <- map["postTypeId"]
        userId <- map["userId"]
        postImage <- map["postImage"]
        embedId <- map["embedId"]
        mediaType <- map["mediaType"]
        postType <- map["postType"]
        categoryName <- map["categoryName"]
        likeCount <- map["likeCount"]
        disLikeCount <- map["disLikeCount"]
        commentCount <- map["commentCount"]
        viewCount <- map["viewCount"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        postUpdatedDate <- map["postUpdatedDate"]
        
        
        
    }
    
    
}
