//
//  GetChurchByIDResultVo.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

/*{
    "countryId": 1,
    "countryName": "India ",
    "stateId": 3,
    "stateName": "Telangana",
    "districtId": 7,
    "districtName": "Hyderabad",
    "mandalId": 12,
    "mandalName": "Tirumalagiri",
    "villageName": "Ammuguda",
    "pinCode": 500011,
    "churchImage": "http://services.teluguchurches.church/FileRepository/2018\\07\\02\\Church\\20180702101225758.jpg",
    "userImage": "http://services.teluguchurches.church/FileRepository/2018\\07\\02\\User\\20180702103709300.jpg",
    "userName": "brothetAnilkumar",
    "id": 3,
    "name": "Anil World Evangelism (AWE Ministries)",
    "registrationNumber": "Anil World Evangelism1",
    "address1": "Plot no.3, Road no.12, Huda Heights",
    "address2": "M.L.A Colony, Near Loctus Pond",
    "landMark": "Banjara Hills",
    "villageId": 5,
    "description": "Anil World Evangelism is an interdenominational organisation that seeks to build, encourage and inspire people with good news of Lord Jesus Christ. Anil World Evangelism Shares Love and Compassion of Jesus Christ to the millions of broken hearted people around the world. These ministries are currently engaging more than 2 million in reached people around the world. We were completely capable of evangelising the lost and taking the gospel to the corners of the earth.",
    "mission": null,
    "vision": null,
    "contactNumber": "04040477777",
    "email": "contact@broanilkumar.com",
    "websiteAddress": "http://www.broanilkumar.com",
    "fileLocation": "2018\\07\\02\\Church",
    "fileName": "20180702101225758",
    "fileExtention": ".jpg",
    "isActive": true,
    "createdByUserId": 13,
    "createdDate": "2018-06-08T12:47:25.683",
    "updatedByUserId": 92,
    "updatedDate": "2018-09-10T14:38:51.063",
    "openingTime": "10:30:00",
    "closingTime": "17:30:00",
    "latitude": 17.4141075,
    "longitude": 78.430059300000039,
    "address": "Plot no.3, Road no.12, Huda Heights M.L.A Colony, Near Loctus Pond ",
    "pasterUser": "Anil Kumar Bro",
    "userContactNumbar": "04040477777",
    "userEmail": "susmitha@calibrage.in",
    "dob": "1972-02-12T07:30:00",
    "genderTypeId": 27,
    "gender": "Male",
    "userDescription": "Anil World Evangelism is an interdenominational organisation that seeks to build, encourage and inspire people with good news of Lord Jesus Christ. Anil World Evangelism Shares Love and Compassion of Jesus Christ to the millions of broken hearted peo",
    "createdByUser": "Susmitha Yeruva",
    "updatedByUser": "ravali n",
    "isSubscribed": 0
}*/

import Foundation
class GetChurchByIDResultVo: Mappable {
    
 

    //MARK:-  Declaration of GetChurchByIDResultVo
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
    
    var userEmail : String?
    var genderTypeId : Int?
    var userDescription : String?
    var latitude: Double?
    var longitude: Double?
    
    
    
    //MARK:-  initialization of GetChurchByIDResultVo
    
    
    init(Id : Int?,name : String?,registrationNumber : String?,address1 : String?,address2 : String?,landMark : String?,countryId : Int?,countryName : String?,stateId : Int?,stateName : String?,districtId : Int?,districtName : String?,mandalId : Int?,mandalName : String?,villageId : Int?,villageName : String?,description : String?,mission : String?,vision : String?,contactNumber : String?,email : String?,websiteAddress : String?,openingTime : String?,closingTime : String?,churchImage : String?,userImage : String?,pasterUserId : Int?,isActive : Bool?,pasterUser : String?,createdByUser : String?,updatedByUser : String?,updatedDate : String?,updatedByUserId : Int?,fileName : String?,fileLocation : String?,fileExtention : String?,createdDate : String?,createdByUserId : Int?,userContactNumbar : String?,gender : String?,dob : String?,userName : String?,pinCode : Int?, isSubscribed : Int?,userEmail : String?,genderTypeId : Int?, userDescription : String?,latitude:Double?, longitude: Double?)
        
        
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
        
        self.userEmail = userEmail
        self.genderTypeId = genderTypeId
        self.userDescription = userDescription
        self.latitude = latitude
        self.longitude = longitude

        
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
        
        
        userEmail <- map["userEmail"]
        genderTypeId <- map["genderTypeId"]
        userDescription <- map["userDescription"]
        
        latitude <- map["latitude"]
        longitude <- map["longitude"]

    }
    
    
}
