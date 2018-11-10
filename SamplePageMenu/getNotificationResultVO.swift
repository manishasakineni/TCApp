//
//  getNotificationVO.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 10/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class getNotificationResultVO: Mappable {
    
    
    //MARK:-  Declaration of GetProfileResultInfoVO
    
    var listResult: Any?
    var result : getNotificationCount?
    var isSuccess: Bool?
    var affectedRecords: Int?
    var totalRecords : Int?
    var endUserMessage: String?
    var exception : Any?
    
    
    //MARK:-  initialization of GetProfileResultInfoVO
    
    init(listResult: Any?, result : getNotificationCount?, isSuccess: Bool?,affectedRecords: Int?, totalRecords : Int?, endUserMessage: String?,exception : Any?) {
        self.listResult = listResult
        self.result = result
        self.isSuccess = isSuccess
        self.affectedRecords = affectedRecords
        self.totalRecords = totalRecords
        self.endUserMessage = endUserMessage
        self.exception = exception
       
        
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
        
    }
}
