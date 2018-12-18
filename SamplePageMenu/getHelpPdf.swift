//
//  File.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 18/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class getHelpPdf: Mappable {
    
    
    //MARK:-  Declaration of GetProfileResultInfoVO
    
    var listResult: Any?
    var result : String?
    var isSuccess: Bool?
    var affectedRecords: Int?
    var totalRecords : Int?
    var endUserMessage: String?
    var exception : Any?
    var validationErrors : String?
    
    //MARK:-  initialization of GetProfileResultInfoVO
    
    init(listResult: Any?, result : String?, isSuccess: Bool?,affectedRecords: Int?, totalRecords : Int?, endUserMessage: String?,exception : Any?, validationErrors : String?) {
        self.listResult = listResult
        self.result = result
        self.isSuccess = isSuccess
        self.affectedRecords = affectedRecords
        self.totalRecords = totalRecords
        self.endUserMessage = endUserMessage
        self.exception = exception
        self.validationErrors = validationErrors
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        listResult <- map["listResult"]
        result <- map["result"]
        isSuccess <- map["isSuccess"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        totalRecords <- map["totalRecords"]
        exception <- map["exception"]
        validationErrors <- map["validationErrors"]
        
    }
}
