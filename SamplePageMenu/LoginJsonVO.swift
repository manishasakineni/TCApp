//
//  LoginJsonVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/10/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

//{
//    "listResult": null,
//    "result":{
//        "access_token": "dXmC3CjJJuZUP9ux7QzRRWhnXWz0c8PO-07kCillRao3zrolBjZgh9juQWiGoCapre_c1hdQNby0oFiXqYXZkhGKonABPwNuUHV1Vd3_wZH768jznda4DJ-rb2qMgFvplFB2kjEqCGnKDJwJtPxPwHUNXnTqIW_Hfnan32gcW23JX3yYaG4ZpqmW4DfAoCypjBlyM5KlC8h_MgdMn1FUbJlZrT5zGIP0I5M-VmqwhMS6jy-FjRvU3Zlz3W6_b9tOs_YeKglAXIkhdS0GjMdaeHlekqsW3VAs9ZlM7K2a6_8jFxQE1W-csNhirB1bXzCwyFudX9rKZLtVCHbZN41OCQ",
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
//    },
//    "isSuccess": true,
//    "affectedRecords": 1,
//    "totalRecords": 0,
//    "endUserMessage": "Login Successful",
//    "validationErrors":[],
//    "exception": null
//}

import Foundation

class LoginJsonVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    var listResult: Any?
    
    var result: LoginVo?
    
    var affectedRecords: Int?
    var isSuccess: Bool?
    var endUserMessage: String?
    var validationErrors : NSArray?
    var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(result: LoginVo?, listResult:Any?, affectedRecords: Int?, isSuccess: Bool?, endUserMessage: String?, validationErrors: NSArray?, exception: Any?) {
        
        
        self.result = result
        self.listResult = listResult
        self.affectedRecords = affectedRecords
        self.isSuccess = isSuccess
        self.endUserMessage = endUserMessage
        self.validationErrors = validationErrors
        self.exception = exception
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        result <- map["result"]
        listResult <- map["listResult"]
        affectedRecords <- map["affectedRecords"]
        isSuccess <- map["isSuccess"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
    }
    
    
}

