//
//  LoginVo.swift
//  Telugu Churches
//
//  Created by Mac OS on 31/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

//    "result":{
//        "access_token": "ZN41OCQ",
//        "token_type": "bearer",
//        "expires_in": 1799,
//        "client_id": "ConsoleApp",
//        "userName": "bhavani",
//        "userId": "d8335be1-de82-4bb9-a5ae-9c142c09dacc",
//        "issued": null,
//        "expires": null,
//        "refresh_token": "bf20b176511a4db8b88126d5a2755c9c",
//        "roleName": "Follower",
//        "userDetails":{"id": 51, "userId": "d8335be1-de82-4bb9-a5ae-9c142c09dacc", "firstName": "Bhavani", "lastname": "maddu",…},
//        "activityRights":[
//        {
//        "id": 8,
//        "name": "Can Manage Churches",
//        "desc": "Can Manage Churches",
//        "isActive": true,
//        "createdByUserId": 13,
//        "createdDate": "2018-03-09T02:00:31.27",
//        "updatedByUserId": 13,
//        "updatedDate": "2018-03-09T02:00:31.27"
//        },
//        {"id": 9, "name": "Can View Posts", "desc": "Can View Posts", "isActive": true,…},
//        {"id": 11, "name": "Can View Events", "desc": "Can View Events", "isActive": true,…}
//        ]
//    }

import Foundation

class LoginVo: Mappable {
    
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var client_id: String?
    var userName : String?
    var userId : String?
    var issued : Any?
    var expires : Any?
    var refresh_token : String?
    var roleName : String?
    var userDetails : UserDetailsVO?
    var activityRights : [ActivityRightsVo]?
    
    //    var contactNumber : Int?
    //    var email : String?
    //    var id : Int?
    //    var mobileNumber : Int?
    //    var name : String?
    //    var roleId : Int?
    //    var roleName : String?
    //    var userId : String?
    //    var userName : Int?
    //    var gender : String?
    //    var dob : String?
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(access_token: String?,token_type: String?,expires_in: Int?,client_id: String?,userName: String?,userId: String?,issued: Any?,expires: Any?,refresh_token: String?,roleName: String?,userDetails: UserDetailsVO?, activityRights: [ActivityRightsVo]?
        ) {
        
        
        self.access_token = access_token
        self.token_type = token_type
        self.expires_in = expires_in
        self.client_id = client_id
        self.userName = userName
        self.userId = userId
        self.roleName = roleName
        self.issued = issued
        self.expires = expires
        self.refresh_token = refresh_token
        self.userDetails = userDetails
        self.activityRights = activityRights
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
        userId <- map["userId"]
        userName <- map["userName"]
        roleName <- map["roleName"]
        issued <- map["issued"]
        userId <- map["userId"]
        userName <- map["userName"]
        expires <- map["expires"]
        refresh_token <- map["refresh_token"]
        userDetails <- map["userDetails"]
        activityRights <- map["activityRights"]
        
    }
    
    
}

