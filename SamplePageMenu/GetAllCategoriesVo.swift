//
//  GetAllCategoriesVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class GetAllCategoriesVo: Mappable {
    
    //MARK:-  Declaration of GetAllCategoriesVo
    
    var listResult : [CategoriesResultVo]?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
    
    //MARK:-  initialization of GetAllCategoriesVo
    
    
    init(listResult : [CategoriesResultVo]?, isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?) {
        
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
