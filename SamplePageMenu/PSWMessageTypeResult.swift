//
//  PSWMessageTypeResult.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation





class PSWMessageTypeResult: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    //  var result: RegisterVo?
    //  var isSuccess: Bool?
    
     var modelState: ChangePassWordResult?

    //  var endUserMessage: String?
    //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(modelState: ChangePassWordResult?) {
        self.modelState = modelState
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        modelState <- map["modelState"]
    }
}
