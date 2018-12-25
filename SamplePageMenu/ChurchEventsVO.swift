//
//  ChurchEventsVO.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 25/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class ChurchEventsVO: Mappable {
    
    
    //MARK:-  Declaration of GetProfileResultInfoVO
    
    var listResult: [ChurchEventsListVO]?
    var isSuccess: Bool?
    var affectedRecords: Int?
    var totalRecords : Int?
    var endUserMessage: String?
    var validationErrors : Any?
    var exception : Any?
    
    
    //MARK:-  initialization of GetProfileResultInfoVO
    
    init(listResult: [ChurchEventsListVO]?, isSuccess: Bool?,affectedRecords: Int?, totalRecords : Int?, endUserMessage: String?,validationErrors : Any?, exception : Any?) {
        
        self.listResult = listResult
     
        self.isSuccess = isSuccess
        self.affectedRecords = affectedRecords
        self.totalRecords = totalRecords
        self.endUserMessage = endUserMessage
        self.validationErrors = validationErrors
        self.exception = exception
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        listResult <- map["listResult"]
 
        isSuccess <- map["isSuccess"]
        affectedRecords <- map["affectedRecords"]
        endUserMessage <- map["endUserMessage"]
        totalRecords <- map["totalRecords"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
        
    }
}

