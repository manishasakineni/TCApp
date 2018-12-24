//
//  VideoSongsVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/14/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class GetCategoriesResultVo: Mappable {
   
    //MARK:-  Declaration of GetCategoriesResultVo
    
    var listResult : Any?
    var result : CategoriesListResultVo?
    var isSuccess    : Bool?
    var totalRecords : Int?
    var affectedRecords : Int?
    var endUserMessage : String?
    var validationErrors : String?
    var exception : Any?
    
    
    //MARK:-  initialization of GetCategoriesResultVo
    
    
    init(listResult : Any?,result : CategoriesListResultVo?, isSuccess : Bool?, totalRecords:Int?, affectedRecords:Int?,endUserMessage:String?, validationErrors:String?,exception:Any?) {
        
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
