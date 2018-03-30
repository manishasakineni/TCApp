//
//  GetChurchByIDResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class GetChurchByIDResultVo: Mappable {
    
    
//    
//    address1 = "sample string 20";
//    address2 = "<null>";
//    churchImage = "<null>";
//    closingTime = "21.3";
//    contactNumber = 9578945215;
//    countryId = 1;
//    countryName = India;
//    createdByUser = "Anushka Shetty";
//    createdByUserId = 219;
//    createdDate = "2018-02-21T14:27:06.82";
//    description = "sample string 24";
//    districtId = 1;
//    districtName = Guntur;
//    email = "dsahdbj@cmn.com";
//    fileExtention = "<null>";
//    fileLocation = "<null>";
//    fileName = "<null>";
//    id = 37;
//    isActive = 1;
//    landMark = "sample string 22";
//    mandalId = 1;
//    mandalName = Cherukupalli;
//    mission = "sample string 25";
//    name = SimpleChurch;
//    openingTime = "9.15";
//    pasterUser = "Deepl Padukoneas";
//    registrationNumber = Reg101;
//    stateId = 1;
//    stateName = "Andhra Pradesh";
//    updatedByUser = "Anushka Shetty";
//    updatedByUserId = 219;
//    updatedDate = "2018-02-21T14:27:06.82";
//    userImage = "<null>";
//    villageId = 2;
//    villageName = Cherukupalli;
//    vision = "sample string 26";
//    websiteAddress = "sample string 29";
//    userContactNumbar = 567686897868;

//}






    //MARK:-  Declaration of VideosVO
    var Id : Int?
    var name : String?
    var registrationNumber    : String?
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
    var villageName : String?
    var description : String?
    var mission : String?
    var vision    : String?
    var contactNumber : String?
    var email : String?
    var websiteAddress : String?
    var openingTime : String?
    var closingTime : String?
    var churchImage : String?
    var userImage : String?
    var pasterUserId : Int?
    var isActive    : Bool?
    var pasterUser : String?
    var createdByUser : String?
    var updatedByUser : String?
    var updatedDate : String?
    
    var updatedByUserId : Int?
    
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var createdDate : String?
    var createdByUserId : Int?
    var userContactNumbar : String?
    
    var gender : String?
    var dob : String?
    var userName : String?
    var pinCode : Int?
    var isSubscribed : Int?
    
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(Id : Int?,name : String?,registrationNumber : String?,address1 : String?,address2 : String?,landMark : String?,countryId : Int?,countryName : String?,stateId : Int?,stateName : String?,districtId : Int?,districtName : String?,mandalId : Int?,mandalName : String?,villageId : Int?,villageName : String?,description : String?,mission : String?,vision : String?,contactNumber : String?,email : String?,websiteAddress : String?,openingTime : String?,closingTime : String?,churchImage : String?,userImage : String?,pasterUserId : Int?,isActive : Bool?,pasterUser : String?,createdByUser : String?,updatedByUser : String?,updatedDate : String?,updatedByUserId : Int?,fileName : String?,fileLocation : String?,fileExtention : String?,createdDate : String?,createdByUserId : Int?,userContactNumbar : String?,gender : String?,dob : String?,userName : String?,pinCode : Int?, isSubscribed : Int?)
        
        
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
        self.description = description
        self.mission = mission
        self.vision = vision
        self.contactNumber = contactNumber
        self.email = email
        self.websiteAddress = websiteAddress
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.churchImage = churchImage
        self.userImage = userImage
        self.pasterUserId = pasterUserId
        self.isActive = isActive
        self.pasterUser = pasterUser
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        self.updatedDate = updatedDate
        self.updatedByUserId = updatedByUserId
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.createdDate = createdDate
        self.createdByUserId = createdByUserId
        self.userContactNumbar = userContactNumbar
        
        self.gender = gender
        self.dob = dob
        self.userName = userName
        self.userName = userName
        self.pinCode = pinCode
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
        description <- map["description"]
        mission <- map["mission"]
        vision <- map["vision"]
        contactNumber <- map["contactNumber"]
        email <- map["email"]
        websiteAddress <- map["websiteAddress"]
        openingTime <- map["openingTime"]
        closingTime <- map["closingTime"]
        churchImage <- map["churchImage"]
        userImage <- map["userImage"]
        pasterUserId <- map["pasterUserId"]
        isActive <- map["isActive"]
        pasterUser <- map["pasterUser"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        updatedDate <- map["updatedDate"]
        updatedByUserId <- map["updatedByUserId"]
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        createdDate <- map["createdDate"]
        createdByUserId <- map["createdByUserId"]
        userContactNumbar <- map["userContactNumbar"]
        
        gender <- map["gender"]
        dob <- map["dob"]
        userName <- map["userName"]
        
        pinCode <- map["pinCode"]
        isSubscribed  <- map["isSubscribed"]
    }
    
    
}
