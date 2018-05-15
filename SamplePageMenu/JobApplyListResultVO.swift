//
//  JobApplyListResultVO.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class JobApplyListResultVO: Mappable {
    
    
    
    var id : Int?
    var jobId : Int?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var mobileNumber : String?
    var email : String?
    var qualification : String?
    var applyingFor : String?
    var yearsofExp : String?
    
    
    var fileName : String?
    var fileLocation : String?
    var fileExtention : String?
    var currentOrganization : String?
    var currentSalary : Int?
    var expectedSalary : Int?
    var isActive : Bool?
    var createdByUserId : Int?
    var createdDate : String?
    var updatedByUserId : Int?
    
    var updatedDate : String?
    var jobTitle : String?
    var applicantName : String?
    var doc : String?
    var createdByUser : String?
    var updatedByUser : String?
    

    
    
    init(id: Int?,jobId: Int?,firstName: String?, middleName: String?, lastName: String?, mobileNumber: String?, email: String?, qualification : String?, applyingFor : String?, yearsofExp : String?,fileName: String?,fileLocation: String?,fileExtention: String?, currentOrganization: String?, currentSalary: Int?, expectedSalary: Int?, isActive: Bool?, createdByUserId : Int?, createdDate : String?, updatedByUserId : Int?,updatedDate: String?,jobTitle: String?,applicantName: String?, doc: String?, createdByUser: String?, updatedByUser: String?)
        
        
    {
        
        
        self.id = id
        self.jobId = jobId
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.email = email
        self.qualification = qualification
        self.applyingFor = applyingFor
        self.yearsofExp = yearsofExp
        
        self.fileName = fileName
        self.fileLocation = fileLocation
        self.fileExtention = fileExtention
        self.currentOrganization = currentOrganization
        self.currentSalary = currentSalary
        self.expectedSalary = expectedSalary
        self.isActive = isActive
        self.createdByUserId = createdByUserId
        self.createdDate = createdDate
        self.updatedByUserId = updatedByUserId
        
        self.updatedDate = updatedDate
        self.jobTitle = jobTitle
        self.applicantName = applicantName
        self.doc = doc
        self.createdByUser = createdByUser
        self.updatedByUser = updatedByUser
       
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        jobId <- map["jobId"]
        firstName <- map["firstName"]
        middleName <- map["middleName"]
        lastName <- map["lastName"]
        mobileNumber <- map["mobileNumber"]
        email <- map["email"]
        qualification <- map["qualification"]
        applyingFor <- map["applyingFor"]
        yearsofExp <- map["yearsofExp"]
       
        fileName <- map["fileName"]
        fileLocation <- map["fileLocation"]
        fileExtention <- map["fileExtention"]
        currentOrganization <- map["currentOrganization"]
        currentSalary <- map["currentSalary"]
        expectedSalary <- map["expectedSalary"]
        isActive <- map["isActive"]
        createdByUserId <- map["createdByUserId"]
        createdDate <- map["createdDate"]
        updatedByUserId <- map["updatedByUserId"]
        
        updatedDate <- map["updatedDate"]
        jobTitle <- map["jobTitle"]
        applicantName <- map["applicantName"]
        doc <- map["doc"]
        createdByUser <- map["createdByUser"]
        updatedByUser <- map["updatedByUser"]
       

        
        
        
    }
    
    
}

