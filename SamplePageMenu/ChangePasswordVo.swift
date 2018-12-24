//
//  ChangePasswordVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/5/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class ChangePasswordVo: Mappable {
    
    //MARK:-  Declaration of ChangePasswordVo
    
    
    var UserId : String?
    var OldPassword : String?
    var NewPassword : String?
    var ConfirmPassword : String?
    
    //MARK:-  initialization of ChangePasswordVo
    
    
    init(UserId : String?,OldPassword : String?, NewPassword : String?,ConfirmPassword : String?) {
        
        self.UserId = UserId
        self.OldPassword = OldPassword
        self.NewPassword = NewPassword
        self.ConfirmPassword = ConfirmPassword
       
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        UserId <- map["UserId"]
        OldPassword <- map["OldPassword"]
        NewPassword <- map["NewPassword"]
        ConfirmPassword <- map["ConfirmPassword"]
        
    }
    
    
}

