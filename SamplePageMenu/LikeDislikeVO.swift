//
//  LikeDislikeCountVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 02/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//


import Foundation
class LikeDislikeVO: Mappable {
    
    //MARK:-  Declaration of LikeDislikeVO
    
    
    var listResult : Any?
    var result: LikeDislikeCountVO?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
    
    //MARK:-  initialization of LikeDislikeVO
    
    
    init(listResult : Any?, result: LikeDislikeCountVO?,isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?) {
        
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
