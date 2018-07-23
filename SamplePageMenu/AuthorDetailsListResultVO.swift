//
//  AuthorDetailsListResultVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


import Foundation


class AuthorDetailsListResultVO: Mappable {
    
    //MARK:-  Declaration of AuthorDetailsListResultVO
    
     
    var id : Int?
    var userId : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var authorName : String?
    var authorContactNumbar : String?
    var authorEmail : String?
    var dob : String?
    var genderTypeId : Int?
    var gender : String?
    var countryId : Int?
    var churchId : Int?
    var countryName : String?
    var churchName : String?
    var stateId : Int?
    var stateName : String?
    var registrationNumber : String?
    var contactNumber : String?
    var districtId : Int?
    var districtName : String?
    var mandalId : Int?
    var mandalName : String?
    var villageName : String?
    var pinCode : Int?
    var churchImage : String?
    var userImage : String?
    var userName : String?
    var churchAddress : String?
    var createdByUser : String?
    var updatedByUser : String?
    
    var fileName : String?
    var fileExtention : String?
    var eventImage : String?
    
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var isSubscribed : Int?
    
    
    //MARK:-  initialization of AuthorDetailsListResultVO
    
    
    init(id : Int?,userId : String?,firstName : String?,middleName : String?,lastName : String?,authorName : String?,authorContactNumbar : String?,authorEmail : String?,dob : String?,genderTypeId : Int?,gender : String?,countryId : Int?,churchId : Int?,churchName : String?,
        stateId : Int?,stateName : String?,districtId : Int?,districtName : String?,mandalId: Int?,
        mandalName : String?,villageName : String?,pinCode : Int?,churchImage : String?,userImage : String?,userName : String?,churchAddress : String?,createdByUser : String?,updatedByUser : String?,countryName : String?,
         
         registrationNumber : String?,contactNumber : String?,fileLocation : String?,fileName : String?,fileExtention : String?,eventImage : String?,isActive : Bool?,createdByUserId : Int?,createdDate : String?,updatedByUserId : Int?,updatedDate : String?, isSubscribed : Int?)
        
        
    {
        
        
        self.id = id
        self.userId = userId
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.authorName =  authorName
        self.authorContactNumbar = authorContactNumbar
        self.authorEmail = authorEmail
        self.dob = dob
        self.genderTypeId = genderTypeId
        self.gender = gender
        self.countryId = countryId
        self.churchName = countryName
        self.churchId = churchId
        self.churchName = churchName
        self.stateId = stateId
        self.stateName = stateName
        self.districtId = districtId
        self.districtName = districtName
        self.mandalId = mandalId
        self.mandalName = mandalName
        self.villageName = villageName
        self.pinCode = pinCode
        self.churchImage = churchImage
        self.userImage = userImage
        self.userName = userName
        self.registrationNumber = registrationNumber
        self.churchAddress = churchAddress
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        
        self.contactNumber = contactNumber
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        
        
        self.fileName = fileName
        self.fileExtention = fileExtention
        self.eventImage = eventImage
        self.isSubscribed = isSubscribed
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        userId <- map["userId"]
        firstName <- map["firstName"]
        middleName <- map["middleName"]
        lastName <- map["lastName"]
        authorName <- map["authorName"]
        authorContactNumbar <- map["authorContactNumbar"]
        authorEmail <- map["authorEmail"]
        dob <- map["dob"]
        genderTypeId <- map["genderTypeId"]
        gender <- map["gender"]
        countryId <- map["countryId"]
        countryName <- map["countryName"]
        churchId <- map["churchId"]
        stateId <- map["stateId"]
        stateName <- map["stateName"]
        districtId <- map["districtId"]
        districtName <- map["districtName"]
        mandalId <- map["mandalId"]
        mandalName <- map["mandalName"]
        villageName <- map["villageName"]
        pinCode <- map["pinCode"]
        churchImage <- map["churchImage"]
        userImage <- map["userImage"]
        userName <- map["userName"]

        
        churchName <- map["churchName"]
        registrationNumber <- map["registrationNumber"]
        churchAddress <- map["churchAddress"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        
        contactNumber <- map["contactNumber"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        
       
        fileName <- map["fileName"]
        fileExtention <- map["fileExtention"]
        eventImage <- map["eventImage"]
        isSubscribed <- map["isSubscribed"]
        
        
    }
    
    
}
