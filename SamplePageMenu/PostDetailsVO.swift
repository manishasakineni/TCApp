//
//  PostDetailsVO.swift
//  Telugu Churches
//
//  Created by Manoj on 02/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class PostDetailsVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    var id : Int?
    var title : String?
    var desc : String?
    var categoryId : Int?
    var embededUrl : String?
    var mediaTypeId : Int?
    var postTypeId : Int?
    var userId : Int?
    var churchId : Any?
    var fileName : Any?
    var fileLocation : Any?
    var fileExtention : String?
    var isActive : Bool?
    var createdByUserId : Int?
    
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var htmlDesc : Any?
    var eventId : Any?
    var viewCount : Int?
    var postImage : Any?
    var mediaType : String?
    var postType : String?
    var categoryName : String?
    var isLike : Int?
    var isDisLike : Int?
    var likeCount : Int?
    var disLikeCount : Int?
    
    var commentCount : Int?
    var parentCommentId : Int?
    var createdByUser : String?
    var updatedByUser : String?
    //MARK:-  initialization of VideosVO
    
    
    init(id : Int?,title : String?,desc : String?,categoryId : Int?,embededUrl : String?,mediaTypeId : Int?,postTypeId : Int?,userId : Int?,churchId : Any?,fileName : Any?,fileLocation : Any?,fileExtention : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?,htmlDesc : Any?,eventId : Any?,viewCount : Int?,postImage : Any?,mediaType : String?,postType : String?,categoryName : String?,isLike : Int?,isDisLike : Int?,likeCount : Int?,disLikeCount : Int?,commentCount : Int?,parentCommentId : Int?,createdByUser : String?,updatedByUser : String?)
        
        
    {
        
        
        self.id = id
        self.title = title
        self.desc = desc
        self.categoryId = categoryId
        self.embededUrl = embededUrl
        self.mediaTypeId = mediaTypeId
        self.postTypeId = postTypeId
        self.userId = userId
        self.churchId = churchId
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        self.htmlDesc = htmlDesc
        self.eventId = eventId
        self.viewCount = viewCount
        self.postImage = postImage
        self.mediaType = mediaType
        self.postType = postType
        self.categoryName = categoryName
        self.isLike = isLike
        self.isDisLike = isDisLike
        self.likeCount = likeCount
        self.disLikeCount = disLikeCount
        self.commentCount = commentCount
        self.parentCommentId = parentCommentId
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        
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
        churchId <- map["churchId"]
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        
        
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        htmlDesc <- map["htmlDesc"]
        eventId <- map["eventId"]
        viewCount <- map["viewCount"]
        postImage <- map["postImage"]
        mediaType <- map["mediaType"]
        postType <- map["postType"]
        
        categoryName <- map["categoryName"]
        isLike <- map["isLike"]
        isDisLike <- map["isDisLike"]
        likeCount <- map["likeCount"]
        

        disLikeCount <- map["disLikeCount"]
        commentCount <- map["commentCount"]
        parentCommentId <- map["parentCommentId"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]


    }
    
    
}





