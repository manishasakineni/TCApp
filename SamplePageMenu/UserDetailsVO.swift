//
//  UserDetailsVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/10/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class UserDetailsVO: Mappable {
    
    
        
//MARK:-  Declaration of UserDetailsVO
        
   
    var listResult: [LoginVo]?
    var affectedRecords: Int?
    var isSuccess: Bool?
    var endUserMessage: String?
    var validationErrors : NSArray?

        
        //MARK:-  initialization of UserDetailsVO
        
        init(listResult: [LoginVo]?,affectedRecords: Int?,isSuccess: Bool?,endUserMessage: String?,validationErrors : NSArray?) {
            self.listResult = listResult
            self.affectedRecords = affectedRecords
            self.isSuccess = isSuccess
            self.endUserMessage = endUserMessage
            self.validationErrors = validationErrors

            
        }
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            listResult <- map["listResult"]
            affectedRecords <- map["affectedRecords"]
            isSuccess <- map["isSuccess"]
            endUserMessage <- map["endUserMessage"]
            validationErrors <- map["validationErrors"]
        }
    
    
}
