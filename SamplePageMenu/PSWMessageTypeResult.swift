//
//  PSWMessageTypeResult.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class PSWMessageTypeResult: Mappable {
    
    
    //MARK:-  Declaration of PSWMessageTypeResult
    
    
     var modelState: ChangePassWordResult?
    
    //MARK:-  initialization of PSWMessageTypeResult
    
    init(modelState: ChangePassWordResult?) {
        self.modelState = modelState
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        modelState <- map["modelState"]
    }
}
