//
//  ReferStudentModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReferStudentModel: NSObject{
     var addDate         = ""
     var agencyId        = ""
     var agencyType      = ""
     var  email          = ""
     var isEmailVerified = ""
     var emailVerifyDate = ""
     var id              = ""
     var mobileNumber    = ""
     var name            = ""
     var studentId       = ""
    convenience init(with data:[String:Any]) {
        self.init()
        
        if let addDate               = data["add_date"] as? String {
            self.addDate             = addDate
        }
            if let agencyId          = data["agency_id"] as? String {
                self.agencyId        = agencyId
        }
            if let agencyType        = data["agency_type"] as? String {
                self.agencyType      = agencyType
        }
            if let email             = data["email"] as? String {
                self.email           = email
        }
            if let isEmailVerified   = data["email_verify"] as? String {
                self.isEmailVerified = isEmailVerified
        }
            if let emailVerifyDate   = data["email_verify_date"] as? String {
                self.emailVerifyDate = emailVerifyDate
        }
            if let id                = data["id"] as? String {
                self.id              = id
        }
            if let mobileNumber      = data["mobile_number"] as? String {
                self.mobileNumber    = mobileNumber
        }
            if let name              = data["name"] as? String {
                self.name            = name
        }
            if let studentId         = data["student_id"] as? String {
                self.studentId       = studentId
        }
    }
 }
 





/*
 {
     "add_date" = "2020-03-19";
     "agency_id" = 17;
     "agency_type" = A;
     email = "Glasgo@gmail.com";
     "email_verify" = N;
     "email_verify_date" = "0000-00-00 00:00:00";
     id = 110;
     "mobile_number" = 89864556865;
     name = Bchch;
     "student_id" = 50409;
 }
 
 */
