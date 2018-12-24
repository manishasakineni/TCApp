//
//  GetProfileResultInfoVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/8/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class GetProfileResultInfoVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    var listResult: [GetProfileInfoVO]?
    var isSuccess: Bool?
    var affectedRecords: Int?
    var endUserMessage: String?
    var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(listResult: [GetProfileInfoVO]?,isSuccess: Bool?,affectedRecords: Int?,endUserMessage: String?,exception : Any?) {
        self.listResult = listResult
        self.isSuccess = isSuccess
        self.affectedRecords = affectedRecords
        self.endUserMessage = endUserMessage
        self.exception = exception
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        listResult <- map["listResult"]
        isSuccess <- map["isSuccess"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        exception <- map["exception"]
    }
}
