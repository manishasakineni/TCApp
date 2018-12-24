//
//  ChurchDetailsListResultVO.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class ChurchDetailsListResultVO: Mappable {
    
    //MARK:-  Declaration of ChurchDetailsListResultVO
    
    var Id : Int?
    var name : String?
    var registrationNumber : String?
    var address1 : String?
    var address2 : String?
    var landMark : String?
    var countryId : Int?
    var countryName : String?
    var stateId : Int?
    var stateName : String?
    var districtId    : Int?
    var districtName : String?
    var mandalId : Int?
    var mandalName : String?
    var villageId : Int?
    var latitude: Double?
    var longitude: Double?
    var villageName : String?
    var description : String?
    var mission : String?
    var vision    : String?
    var contactNumber : String?
    var email : String?
    var websiteAddress : String?
    var openingTime : String?
    var closingTime : String?
    var churchFileLocation: String?
    var churchFileName: String?
    var churchFileExtention: String?
    var userFileLocation: String?
    var userFileName: String?
    var userFileExtention: String?
    var userContactNumbar: String?
    var userEmail: String?
    var dob: String?
    var genderTypeId: Int?
    var gender: String?
    var userName: String?
    var userDescription: String?
    var churchImage : String?
    var userImage : String?
    var pasterUserId : Int?
    var isActive    : Bool?
    var pasterUser : String?
    var userGuId: String?
    var createdByUser : String?
    var updatedByUser : String?
    var updatedDate : String?
    var createdDate: String?
    var userId : Int?
    var isSubscribed: String?
    
//    "pasterUserId": 7,
//    "isActive": true,
//    "pasterUser": "Anil Kumar Bro",
//    "userGuId": "6eee0754-cafc-49d2-9fce-83a8a026b097",
//    "createdByUser": "Susmitha Yeruva",
//    "updatedByUser": "ravali n",
//    "createdDate": "2018-06-08T12:47:25.683",
//    "updatedDate": "2018-09-10T14:38:51.063",
//    "isSubscribed": 0


    
    //MARK:-  initialization of ChurchDetailsListResultVO
    
    
    init(Id : Int?,name : String?,registrationNumber : String?,address1 : String?,address2 : String?,landMark : String?,countryId : Int?,countryName : String?,stateId : Int?,stateName : String?,districtId : Int?,districtName : String?,mandalId : Int?,mandalName : String?,villageId : Int?,latitude:Double?, longitude: Double?, villageName : String?,description : String?,mission : String?,vision : String?,contactNumber : String?,email : String?,websiteAddress : String?,openingTime : String?,closingTime : String?,churchFileLocation: String?, churchFileName: String?, churchFileExtention: String?, userFileLocation: String?,userFileName: String?, userFileExtention: String?, userContactNumbar: String?, userEmail: String?, dob: String?, genderTypeId: Int?, gender: String?,userName: String?, userDescription: String?, churchImage : String?,userImage : String?,pasterUserId : Int?,isActive : Bool?,pasterUser : String?,userGuId: String, createdByUser : String?,updatedByUser : String?,updatedDate : String?,createdDate: String?, userId : Int?, isSubscribed: String?)
    
    
    {
        
        
        self.Id = Id
        self.name = name
        self.registrationNumber = registrationNumber
        self.address1 = address1
        self.address2 = address2
        self.landMark = landMark
        self.countryId = countryId
        self.countryName = countryName
        self.stateId = stateId
        self.stateName = stateName
        self.districtId = districtId
        self.districtName = districtName
        self.mandalId = mandalId
        self.mandalName = mandalName
        self.villageId = villageId
        self.villageName = villageName
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.mission = mission
        self.vision = vision
        self.contactNumber = contactNumber
        self.email = email
        self.websiteAddress = websiteAddress
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.churchFileLocation = churchFileLocation
        self.churchFileName = churchFileName
        self.churchFileExtention = churchFileExtention
        self.userFileLocation = userFileLocation
        self.userFileName = userFileName
        self.userFileExtention = userFileExtention
        self.userContactNumbar = userContactNumbar
        self.userEmail = userEmail
        self.dob = dob
        self.genderTypeId = genderTypeId
        self.gender = gender
        self.userName = userName
        self.userDescription = userDescription
        self.churchImage = churchImage
        self.userImage = userImage
        self.pasterUserId = pasterUserId
        self.isActive = isActive
        self.pasterUser = pasterUser
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        self.updatedDate = updatedDate
        self.userId = userId
        self.userGuId = userGuId
        self.createdDate = createdDate
        self.isSubscribed = isSubscribed
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        name <- map["name"]
        registrationNumber <- map["registrationNumber"]
        address1 <- map["address1"]
        address2 <- map["address2"]
        landMark <- map["landMark"]
        countryId <- map["countryId"]
        countryName <- map["countryName"]
        stateId <- map["stateId"]
        stateName <- map["stateName"]
        districtId <- map["districtId"]
        districtName <- map["districtName"]
        mandalId <- map["mandalId"]
        mandalName <- map["mandalName"]
        villageId <- map["villageId"]
        villageName <- map["villageName"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        description <- map["description"]
        mission <- map["mission"]
        vision <- map["vision"]
        contactNumber <- map["contactNumber"]
        email <- map["email"]
        websiteAddress <- map["websiteAddress"]
        openingTime <- map["openingTime"]
        closingTime <- map["closingTime"]
        churchFileLocation <- map["churchFileLocation"]
        churchFileName <- map["churchFileName"]
        churchFileExtention <- map["churchFileExtention"]
        userFileLocation <- map["userFileLocation"]
        userFileName <- map["userFileName"]
        userFileExtention <- map["userFileExtention"]
        userContactNumbar <- map["userContactNumbar"]
        userEmail <- map["userEmail"]
        dob <- map["dob"]
        genderTypeId <- map["genderTypeId"]
        gender <- map["gender"]
        userName <- map["userName"]
        userDescription <- map["userDescription"]
        churchImage <- map["churchImage"]
        userImage <- map["userImage"]
        pasterUserId <- map["pasterUserId"]
        isActive <- map["isActive"]
        pasterUser <- map["pasterUser"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        updatedDate <- map["updatedDate"]
        userId <- map["userId"]
        userGuId <- map["userGuId"]
        createdDate <- map["createdDate"]
        isSubscribed <- map["isSubscribed"]
    }
    
    
}
