//
//  GetAllChurchAdminsResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/22/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class GetAllChurchAdminsResultVo: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
//    "id": 3,
//    "churchAdmin": "Aishwarya Sateesh S",
//    "mobileNumber": "7032157345",
//    "email": "Aish@calibrage.in",
//    "churchImage": null,
//    "userImage": null,
//    "churchId": 1056,
//    "churchName": "tetreterte",
//    "updatedDate": "2018-02-22T14:41:01.497"
//},
//

    var Id : Int?
    var churchAdmin : String?
    var mobileNumber    : String?
    var email : String?
    var churchImage : String?
    var userImage : String?
    var churchId : Int?
    var churchName : String?
    var updatedDate : String?
    var isSubscribed : Int?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(Id : Int?,churchAdmin : String?,mobileNumber : String?,email : String?,churchImage : String?,userImage : String?,churchId : Int?,churchName : String?,updatedDate : String?,isSubscribed : Int?)
        
        
    {
        
        
        self.Id = Id
        self.churchAdmin = churchAdmin
        self.mobileNumber = mobileNumber
        self.email = email
        self.churchImage = churchImage
        self.userImage = userImage
        self.churchId = churchId
        self.churchName = churchName
        self.updatedDate = updatedDate
        self.isSubscribed = isSubscribed
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        churchAdmin <- map["churchAdmin"]
        mobileNumber <- map["mobileNumber"]
        email <- map["email"]
        churchImage <- map["churchImage"]
        userImage <- map["userImage"]
        churchId <- map["churchId"]
        churchName <- map["churchName"]
        updatedDate <- map["updatedDate"]
        isSubscribed <- map["isSubscribed"]
        
        
    }
    
    
}
