//
//  LoginJsonVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/10/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class LoginJsonVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    //  var result: RegisterVo?
    //  var isSuccess: Bool?
    
    
    
    //MARK:-  Declaration of SignupVo
 
    var userDetails: UserDetailsVO?
   // var userActivityRights: [UserActivityRightsVO]?

    //  var endUserMessage: String?
    //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(userDetails: UserDetailsVO?) {
        self.userDetails = userDetails
      //  self.userActivityRights = userActivityRights
      
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userDetails <- map["userDetails"]
     //   userActivityRights <- map["userActivityRights"]
       

    }
}
