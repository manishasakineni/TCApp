//
//  UserDetailsVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/10/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

//        "userDetails":{"id": 51, "userId": "d8335be1-de82-4bb9-a5ae-9c142c09dacc", "firstName": "Bhavani", "lastname": "maddu",…}

import Foundation

class UserDetailsVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    
    var id: Int?
    var userId: String?
    var firstName: String?
    var lastname: String?
    
    
    //MARK:-  initialization of SignupVo
    
    init(id: Int?, userId: String?, firstName: String?,lastname: String?) {
        
        self.id = id
        self.userId = userId
        self.firstName = firstName
        self.lastname = lastname
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        userId <- map["userId"]
        firstName <- map["firstName"]
        lastname <- map["lastname"]
        
    }
    
    
}

