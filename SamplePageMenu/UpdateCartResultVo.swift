//
//  UpdateCartResultVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 14/09/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

/* "id": 188,
"itemId": 44,
"quantity": 4,
"itemName": "The Holy Bible in Audio",
"price": 835,
"author": "King James",
"fileName": "20180803034124035",
"fileLocation": "2018\\08\\03\\Items/Audio",
"fileExtention": ".jpg",
"itemImage": "http://services.teluguchurches.church/FileRepository/2018\\08\\03\\Items/Audio\\20180803034124035.jpg",
"itemType": "Audio" */

import Foundation


class UpdateCartResultVo: Mappable {
    
    var id : Int?
    var itemId : Int?
    var quantity : Int?
    var itemName : String?
    var price : Int?
    var author : String?
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var itemImage : String?
    var itemType : String?
    
    //MARK:-  initialization of GetCartListResultVO
    
    init(id: Int?,itemId: Int?,quantity: Int?, itemName: String?, price: Int?, author: String?, fileName: String?, fileLocation : String?, fileExtention : String?, itemImage : String?,itemType: String?)
        
        
    {
        
        
        self.id = id
        self.itemId = itemId
        self.quantity = quantity
        self.itemName = itemName
        self.price = price
        self.author = author
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.itemImage = itemImage
        self.itemType = itemType
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        itemId <- map["itemId"]
        quantity <- map["quantity"]
        itemName <- map["itemName"]
        price <- map["price"]
        author <- map["author"]
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        itemImage <- map["itemImage"]
        
        itemType <- map["itemType"]
        
        
    }
}
