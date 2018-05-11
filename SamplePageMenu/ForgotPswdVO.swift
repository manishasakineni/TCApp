//
//  ForgotPswdVO.swift
//  Telugu Churches
//
//  Created by Manoj on 11/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class ForgotPswdVO: Mappable {
    
    
//    "listResult": null,
//    "result": null,
//    "isSuccess": true,
//    "affectedRecords": 0,
//    "totalRecords": 0,
//    "endUserMessage": "Your Password has been sent to Your Registered Email Address",
//    "validationErrors": [],
//    "exception": null
//    
    var listResult : Any?
    var result : Any?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(listResult : Any?, result : Any?, isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?) {
        
        self.listResult = listResult
        self.result = result
        self.isSuccess = isSuccess
        self.totalRecords = totalRecords
        self.affectedRecords = affectedRecords
        self.endUserMessage = endUserMessage
        self.validationErrors = validationErrors
        self.exception = exception
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        listResult <- map["listResult"]
        result <- map["result"]
        isSuccess <- map["isSuccess"]
        totalRecords <- map["totalRecords"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
        
    }
}
