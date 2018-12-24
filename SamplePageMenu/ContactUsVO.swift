//
//  ContactUsVO.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class ContactUsVO: Mappable {
    
    
//    "email": "teluguchurches.church",
//    "contactNo": "040-48525410",
//    "address": "132/A II Floor",
//    "companyName": "Calibrage Info System",
//    "landmark": "Road No : 06, Western Hills",
//    "village": "Kukatpally",
//    "mandal": "Medchal",
//    "district": "Hyderabad",
//    "state": "Telangana"
    
    var email: String?
    var contactNo : String?
    var address: String?
    var companyName: String?
    var landmark : String?
    var village: String?
    var mandal : String?
    var district : String?
    var state : String?
    
    //MARK:-  initialization of GetProfileResultInfoVO
    
    init(email : String?, contactNo: String?,address: String?, companyName : String?, landmark: String?,village : String?, mandal : String?,district : String?, state : String?) {
        
        self.email = email
        self.contactNo = contactNo
        self.address = address
        self.companyName = companyName
        self.landmark = landmark
        self.village = village
        self.mandal = mandal
        self.district = district
        self.state = state
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        contactNo <- map["contactNo"]
        address <- map["address"]
        companyName <- map["companyName"]
        landmark <- map["landmark"]
        village <- map["village"]
        mandal <- map["mandal"]
        district <- map["district"]
        state <- map["state"]
        
    }
}
