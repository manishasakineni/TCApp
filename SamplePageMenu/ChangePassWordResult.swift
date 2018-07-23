//
//  ChangePassWordResult.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class ChangePassWordResult: Mappable {
    
   
    //MARK:-  Declaration of ChangePassWordResult
    
    
    var errorMessage: [String]?
    var statusCode : Int?

  //MARK:-  initialization of ChangePassWordResult
    
    init(errorMessage: [String]?,statusCode : Int?) {
        self.errorMessage = errorMessage
        self.statusCode = statusCode
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        errorMessage <- map["errorMessage"]
        statusCode <- map["statusCode"]
    }
}
