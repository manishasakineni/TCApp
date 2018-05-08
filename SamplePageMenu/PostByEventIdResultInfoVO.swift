//
//  PostByEventIdResultInfoVO.swift
//  Telugu Churches
//
//  Created by Manoj on 07/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class PostByEventIdResultInfoVO: Mappable {


    var id : Int?
    var title : String?
    var desc : String?
    var categoryId : Any?
    var embededUrl : Any?
    var mediaTypeId : Int?
    var postTypeId : Int?
    
    var userId : Any?
    var churchId : Any?
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var isActive : Bool?
    var createdByUserId : Int?

    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var htmlDesc : String?
    var eventId : Int?
    var viewCount : Bool?
    var postImage : String?
    var mediaType : String?
    var postType : String?
    var categoryName : Bool?
    var eventTitle : String?
    var startDate : String?
    var likeCount : Int?
    var disLikeCount : Int?
     var commentCount : Int?
    var createdByUser : String?
    var updatedByUser : String?


    
    init(id: Int?,title: String?,desc: String?, categoryId:Any?, embededUrl: Any?, mediaTypeId: Int?, postTypeId: Int?,userId: Any?,churchId: Any?,fileName: String?, fileLocation:String?, fileExtention: String?, isActive: Bool?, createdByUserId: Int?,createdDate: String?,updatedByUserId: Int?,updatedDate: String?, htmlDesc:String?, eventId: Int?, viewCount: Bool?, postImage: String?,mediaType: String?,postType: String?,categoryName: Bool?, eventTitle:String?, startDate: String?, likeCount: Int?, disLikeCount: Int?, commentCount: Int?, createdByUser: String?, updatedByUser: String?)
        
        
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
        self.eventTitle = eventTitle
        self.startDate = startDate
        self.likeCount = likeCount
        self.disLikeCount = disLikeCount
        self.commentCount = commentCount
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
        eventTitle <- map["eventTitle"]
        startDate <- map["startDate"]
        likeCount <- map["likeCount"]
        disLikeCount <- map["disLikeCount"]
        
        commentCount <- map["commentCount"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        

        
    }
    
    
}
