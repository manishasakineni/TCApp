//
//  AuthorEventsVO.swift
//  Telugu Churches
//
//  Created by Arun Gattadi on 25/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class AuthorEventsVO: Mappable {
    
    //MARK:-  Declaration of AuthorEventsResultVO
    
    var listResult : [AuthorEventsListInfoVO]?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : Any?
    var exception : Any?
    
    //MARK:-  initialization of AuthorEventsResultVO
    
    init(listResult : [AuthorEventsListInfoVO]?, isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:Any?,exception:Any?) {
        
        self.listResult = listResult
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
        isSuccess <- map["isSuccess"]
        totalRecords <- map["totalRecords"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
        
    }
    
    
    
}
