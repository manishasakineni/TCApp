//
//  GetProfileInfoVO.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/8/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class GetProfileInfoVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
    //    "UserName" : "",
    //    "UserId" : "",
    //    "Email" : "king@gmail.com",
    //    "UpdatedByUserId" : 1,
    //    "LastName" : "dewfefe",
    //    "ContactNumber" : "2457561545",
    //    "IsActive" : true,
    //    "gender" : 21,
    //    "MiddleName" : "dwddwd",
    //    "CreatedDate" : "2018-01-31T10:43:28.8319786+05:30",
    //    "Id" : 36,
    //    "FirstName" : "efewdw",
    //    "CreatedByUserId" : 1,
    //    "UpdatedDate" : "2018-01-31T10:43:28.8329795+05:30",
    //    "MobileNumber" : "",
    //    "RoleId" : 1,
    //    "Password" : "",
    //    "dob" : "Feb 06, 2018"
    //
    
    var Id : Int?
    var UserId : String?
    var FirstName : String?
    var Lastname : String?
    var MiddleName : String?
    var ContactNumber : String?
    var MobileNumber : String?
    var UserName : String?
    var Password : String?
    var RoleId : Int?
    var Email : String?
    var IsActive : Bool?
    var CreatedByUserId : Int?
    var CreatedDate : String?
    var UpdatedByUserId : Int?
    var UpdatedDate : String?
    
    var dob : String?
    var gender : String?
    var genderTypeId : Int?
    var userImage : String?
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(Id:Int?, UserId : String?,FirstName : String?, Lastname : String?,MiddleName : String?,ContactNumber : String?,MobileNumber : String?,UserName : String?,Password : String?,RoleId : Int?,Email : String?,IsActive : Bool?,CreatedByUserId : Int?,UpdatedByUserId : Int?,UpdatedDate : String?,dob : String?,gender : String?,CreatedDate : String?,genderTypeId : Int?, userImage : String?) {
        
        self.Id = Id
        self.FirstName = FirstName
        self.Lastname = Lastname
        self.MiddleName = MiddleName
        self.ContactNumber = ContactNumber
        self.MobileNumber = MobileNumber
        self.UserName = UserName
        self.Password = Password
        self.RoleId = RoleId
        self.Email = Email
        self.IsActive = IsActive
        self.CreatedByUserId = CreatedByUserId
        self.UpdatedByUserId = UpdatedByUserId
        self.CreatedDate = CreatedDate
        self.UpdatedDate = UpdatedDate
        
        self.dob = dob
        self.gender = gender
        self.genderTypeId = genderTypeId
        self.userImage = userImage
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        FirstName <- map["firstName"]
        Lastname <- map["lastName"]
        MiddleName <- map["middleName"]
        ContactNumber <- map["contactNumber"]
        MobileNumber <- map["mobileNumber"]
        UserName <- map["userName"]
        Password <- map["password"]
        RoleId <- map["roleId"]
        Email <- map["email"]
        IsActive <- map["isActive"]
        CreatedByUserId <- map["createdByUserId"]
        UpdatedByUserId <- map["updatedByUserId"]
        CreatedDate <- map["CreatedDate"]
        UpdatedDate <- map["updatedDate"]
        
        dob <- map["dob"]
        gender <- map["gender"]
        genderTypeId <- map["genderTypeId"]
        userImage <- map["userImage"]
    }
    
    
}
