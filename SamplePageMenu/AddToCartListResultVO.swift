//
//  AddToCartListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 17/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class AddToCartListResultVO: Mappable {
    
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

