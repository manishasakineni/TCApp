//
//  LoginResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/2/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class LoginResultVo: Mappable {
    
//MARK:-  Declaration of LoginResultVo
    
    var contactNumber : Int?
    var email : String?
    var id : Int?
    var mobileNumber : Int?
    var name : String?
    var roleId : Int?
    var roleName : String?
    var userId : String?
    var userName : Int?
    var gender : String?
    var dob : String?
    

    
    //MARK:-  initialization of LoginResultVo
    
    
    init(contactNumber : Int?,email : String?,id : Int?,mobileNumber : Int?,name : String?,roleId : Int?,roleName : String?,userId : String?,userName : Int?,gender : String?,dob : String?
) {
        
        
        self.contactNumber = contactNumber
        self.email = email
        self.id = id
        self.mobileNumber = mobileNumber
        self.name = name
        self.roleId = roleId
        self.roleName = roleName
        self.userId = userId
        self.userName = userName
        self.gender = gender
        self.dob = dob

        
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        contactNumber <- map["contactNumber"]
        email <- map["email"]
        id <- map["id"]
        mobileNumber <- map["mobileNumber"]
        name <- map["name"]
        roleId <- map["roleId"]
        roleName <- map["roleName"]
        userId <- map["userId"]
        userName <- map["userName"]
        gender <- map["gender"]
        dob <- map["dob"]

    }
 
   
}
