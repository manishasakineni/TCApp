//
//  LoginJsonVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/10/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class LoginJsonVO: Mappable {
    
    
    //MARK:-  Declaration of LoginJsonVO
    
  
 
    var userDetails: UserDetailsVO?
    
    //MARK:-  initialization of LoginJsonVO
    
    init(userDetails: UserDetailsVO?) {
        
        self.userDetails = userDetails
   
      
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userDetails <- map["userDetails"]

       

    }
}
