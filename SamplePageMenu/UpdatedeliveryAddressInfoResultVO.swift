//
//  UpdatedeliveryAddressInfoResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 05/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class UpdatedeliveryAddressInfoResultVO: Mappable {
    
    //MARK:-  Declaration of UpdatedeliveryAddressInfoResultVO

    var id : Int?
    var fullName : String?
    var mobileNumber : String?
    var addressLine1 : String?
    var addressLine2 : String?
    var pinCode : Int?
    var userId : Int?
    var landmark : String?
    var stateId : Int?
    var stateName : String?
    var countryId : Int?
    
    
    var countryName : String?
    var isActive :Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var createdByUser : String?
    var updatedByUser : String?
    var updatedDate : String?
   
     //MARK:-  initialization of UpdatedeliveryAddressInfoResultVO
    
    init(id: Int?,fullName : String?,mobileNumber : String?, addressLine1 : String?, addressLine2 : String?, pinCode : Int?, userId : Int?, landmark : String?, stateId : Int?, stateName : String?,countryId : Int?,countryName : String?,isActive :Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,createdByUser : String?,updatedByUser : String?,updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.fullName = fullName
        self.mobileNumber = mobileNumber
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.pinCode = pinCode
        self.userId = userId
        self.landmark = landmark
        self.stateId = stateId
        self.stateName = stateName
        self.countryId = countryId
        
        self.countryName = countryName
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        self.updatedDate = updatedDate
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        fullName <- map["fullName"]
        mobileNumber <- map["mobileNumber"]
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        pinCode <- map["pinCode"]
        userId <- map["userId"]
        landmark <- map["landmark"]
        stateId <- map["stateId"]
        stateName <- map["stateName"]
        countryId <- map["countryId"]
        
        
        countryName <- map["countryName"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        updatedDate <- map["updatedDate"]
        
    }
    
    
    
}
