//
//  UpdatedCartVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 14/09/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

/*{
    "listResult": [
    {
    "id": 188,
    "itemId": 44,
    "quantity": 4,
    "itemName": "The Holy Bible in Audio",
    "price": 835,
    "author": "King James",
    "fileName": "20180803034124035",
    "fileLocation": "2018\\08\\03\\Items/Audio",
    "fileExtention": ".jpg",
    "itemImage": "http://services.teluguchurches.church/FileRepository/2018\\08\\03\\Items/Audio\\20180803034124035.jpg",
    "itemType": "Audio"
    }
    ],
    "result": null,
    "isSuccess": true,
    "affectedRecords": 1,
    "totalRecords": 0,
    "endUserMessage": "Item Updated to Cart",
    "validationErrors": [],
    "exception": null
} */

import Foundation

class UpdatedCartVo: Mappable {
    
    
    
    //MARK:-  Declaration of RefreshTokenVo
    
    var listResult: UpdateCartResultVo?
    var result: Any?
    var affectedRecords: Int?
    var totalRecords: Int?
    var isSuccess: Bool?
    var endUserMessage: String?
    var validationErrors : NSArray?
    var exception : Any?
    
    //MARK:-  initialization of RefreshTokenVo
    
    init(result: Any?, listResult: UpdateCartResultVo?, affectedRecords: Int?, totalRecords: Int?, isSuccess: Bool?, endUserMessage: String?, validationErrors: NSArray?, exception: Any?) {
        
        
        self.result = result
        self.listResult = listResult
        self.affectedRecords = affectedRecords
        self.totalRecords = totalRecords
        self.isSuccess = isSuccess
        self.endUserMessage = endUserMessage
        self.validationErrors = validationErrors
        self.exception = exception
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        result <- map["result"]
        listResult <- map["listResult"]
        affectedRecords <- map["affectedRecords"]
        totalRecords <- map["totalRecords"]
        isSuccess <- map["isSuccess"]
        endUserMessage <- map["endUserMessage"]
        validationErrors <- map["validationErrors"]
        exception <- map["exception"]
    }
    
    
}





