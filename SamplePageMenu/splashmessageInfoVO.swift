//
//  splashmessageInfoVO.swift
//  Telugu Churches
//
//  Created by Manoj on 09/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class splashmessageInfoVO: Mappable {
    
    
    //MARK:-  Declaration of splashmessageInfoVO
    
    var listResult : Any?
    var result : Any?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
     //MARK:-  initialization of splashmessageInfoVO
    
    init(listResult:Any?, result:Any?,isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?)
        
        
    {
        
        
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
