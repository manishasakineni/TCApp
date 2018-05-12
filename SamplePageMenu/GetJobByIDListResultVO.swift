//
//  GetJobByIDListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 11/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class GetJobByIDListResultVO: Mappable {
    
    

    
    var id : Int?
    var jobTitle : String?
    var vacencies : Int?
    var qualification : String?
    var jobDesc : String?
    var churchId : Int?
    var adminId : Int?
    var contactPerson : String?
    var contactNumber : String?
    var salary : Int?
    
    
    var lastDateToApply : Int?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    var updatedDate : String?
    var adminName : String?
    var churchName : String?
    var createdByUser : String?
    var updatedByUser : String?
    

    
    
    init(id: Int?,jobTitle: String?,vacencies: Int?, qualification: String?, jobDesc: String?, churchId: Int?, adminId: Int?, contactPerson : String?, contactNumber : String?, salary : Int?,lastDateToApply: Int?,isActive: Bool?,createdByUserId: Int?, createdDate: String?, updatedByUserId: Int?, updatedDate: String?, adminName: String?, churchName : String?, createdByUser : String?, updatedByUser : String?)
        
        
    {
        
        
        self.id = id
        self.jobTitle = jobTitle
        self.vacencies = vacencies
        self.qualification = qualification
        self.jobDesc = jobDesc
        self.churchId = churchId
        self.adminId = adminId
        self.contactPerson = contactPerson
        self.contactNumber = contactNumber
        self.salary = salary
        
        
        self.lastDateToApply = lastDateToApply
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        self.updatedDate = updatedDate
        self.adminName = adminName
        self.churchName = churchName
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        jobTitle <- map["jobTitle"]
        vacencies <- map["vacencies"]
        qualification <- map["qualification"]
        jobDesc <- map["jobDesc"]
        churchId <- map["churchId"]
        adminId <- map["adminId"]
        contactPerson <- map["contactPerson"]
        contactNumber <- map["contactNumber"]
        salary <- map["salary"]
        
        
        lastDateToApply <- map["lastDateToApply"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        updatedDate <- map["updatedDate"]
        adminName <- map["adminName"]
        churchName <- map["churchName"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
        

    }
    
    
}

