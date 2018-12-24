//
//  ChangePassWordResult.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


/*result:{
 message = "The request is invalid.";
 modelState =     {
 errorMessage =         (
 "Incorrect password."
 );
 };
 } */


class ChangePassWordResult: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
  //  var isSuccess: Bool?
    var errorMessage: [String]?
    var statusCode : Int?
  //  var endUserMessage: String?
  //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
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
