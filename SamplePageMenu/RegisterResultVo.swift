//
//  RegisterResultVo.swift
//  Telugu Churches
//
//  Created by Mac OS on 31/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class RegisterResultVo: Mappable {
    
        
        //MARK:-  Declaration of RegisterResultVo
        
        var result: RegisterVo?
        var isSuccess: Bool?
        var affectedRecords: Int?
        var endUserMessage: String?
        var exception : Any?
    
        //MARK:-  initialization of RegisterResultVo
        
        init(result: RegisterVo?,isSuccess: Bool?,affectedRecords: Int?,endUserMessage: String?,exception : Any?) {
            self.result = result
            self.isSuccess = isSuccess
            self.affectedRecords = affectedRecords
            self.endUserMessage = endUserMessage
            self.exception = exception

        }
    
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            result <- map["result"]
            isSuccess <- map["isSuccess"]
            affectedRecords <- map["affectedRecords"]
            endUserMessage <- map["endUserMessage"]
            exception <- map["exception"]
        }
    }
