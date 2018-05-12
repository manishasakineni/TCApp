//
//  GetAllJobDetailsListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 11/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class GetAllJobDetailsListResultVO: Mappable {
    
    
    
    var id : Int?
    var jobTitle : String?
    var jobDesc : String?
    
    var qualification : String?
    var lastDateToApply : String?
    var churchName : String?
    var adminName : String?
    var contactPerson : String?
    var contactNumber : String?
    var updatedDate : String?
    
    
    
    init(id: Int?,jobTitle: String?,jobDesc: String?, qualification: String?, lastDateToApply: String?, churchName: String?, adminName: String?, contactPerson : String?, contactNumber : String?, updatedDate : String?)
        
        
    {
        
        
        self.id = id
        self.jobTitle = jobTitle
        self.jobDesc = jobDesc
        self.qualification = qualification
        self.lastDateToApply = lastDateToApply
        self.churchName = churchName
        self.adminName = adminName
        self.contactPerson = contactPerson
        self.contactNumber = contactNumber
        self.updatedDate = updatedDate
        

        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        jobTitle <- map["jobTitle"]
        jobDesc <- map["jobDesc"]
        
        qualification <- map["qualification"]
        lastDateToApply <- map["lastDateToApply"]
        churchName <- map["churchName"]
        
        adminName <- map["adminName"]
        contactPerson <- map["contactPerson"]
        
        
        contactNumber <- map["contactNumber"]
        updatedDate <- map["updatedDate"]

    }
    
    
}

