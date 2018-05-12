//
//  GetJobByIDVO.swift
//  Telugu Churches
//
//  Created by Manoj on 11/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class GetJobByIDVO: Mappable {
    
    
    var listResult : Any?
    
    var result : [GetJobByIDListResultVO]?
    
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
    
    init(listResult:Any?, result: [GetJobByIDListResultVO]?, isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?)
        
        
    {
        
        self.result = result
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
        result <- map["result"]
        isSuccess <- map["isSuccess"]
        totalRecords <- map["totalRecords"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
    }
    
    
}
