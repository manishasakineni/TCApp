//
//  TokenResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 06/09/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class TokenResultVo: Mappable {
    
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var client_id: String?
    var userName : String?
    var userId : String?
    var issued : Any?
    var expires : Any?
    var refresh_token : String?
    
    
    //MARK:-  initialization of RefreshResultVO
    
    
    init(access_token: String?,token_type: String?,expires_in: Int?,client_id: String?,userName: String?,userId: String?,issued: Any?,expires: Any?,refresh_token: String?) {
        
        
        self.access_token = access_token
        self.token_type = token_type
        self.expires_in = expires_in
        self.client_id = client_id
        self.userName = userName
        self.userId = userId
        self.issued = issued
        self.expires = expires
        self.refresh_token = refresh_token
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
        userId <- map["userId"]
        userName <- map["userName"]
        issued <- map["issued"]
        userId <- map["userId"]
        userName <- map["userName"]
        expires <- map["expires"]
        refresh_token <- map["refresh_token"]
        
        
    }
}
