//
//  TokenVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 06/09/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class TokenVo: Mappable {
    
    //MARK:-  Declaration of RefreshTokenVo
    
    var listResult: Any?
    var result: TokenResultVo?
    var affectedRecords: Int?
    var totalRecords: Int?
    var isSuccess: Bool?
    var endUserMessage: String?
    var validationErrors : NSArray?
    var exception : Any?
    
    //MARK:-  initialization of RefreshTokenVo
    
    init(result: TokenResultVo?, listResult: Any?, affectedRecords: Int?, totalRecords: Int?, isSuccess: Bool?, endUserMessage: String?, validationErrors: NSArray?, exception: Any?) {
        
        
        self.result = result
        self.listResult = listResult
        self.affectedRecords = affectedRecords
        self.totalRecords = totalRecords
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
        totalRecords <- map["totalRecords"]
        isSuccess <- map["isSuccess"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
    }
}
