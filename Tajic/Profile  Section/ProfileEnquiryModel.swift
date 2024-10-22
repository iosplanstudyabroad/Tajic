//
//  ProfileEnquiryModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ProfileEnquiryModel: NSObject {
   var userId            = ""
   var agentCrmID        = ""
   var firstName         = ""
   var lastName          = ""
   var mobileNumber      = ""
   var email             = ""
   var interestedCountry = ""
   var year              = ""
   var category          = ""
   var intake            = ""
   var courseType        = ""
  var qrCode           = ""
    
    convenience init(with data:[String:Any]) {
        self.init()
          if let  userId           = data["userid"] as? String {
            self.userId = userId
        }
          if let agentCrmID        = data["app_agent_id"] as? String {
            self.agentCrmID = agentCrmID
        }
          if let firstName         = data["firstname"] as? String {
            self.firstName = firstName
        }
          if let lastName          = data["lastname"] as? String {
            self.lastName = lastName
        }
          if let mobileNumber      = data["mobileNumber"] as? String {
            self.mobileNumber = mobileNumber
        }
          if let email             = data["email"] as? String {
            self.email = email
        }
        if let interestedarr = data["interested_country_title"] as? [[String:Any]],interestedarr.isEmpty == false  {
            var country = [String]()
            interestedarr.forEach { (dict) in
                if let countryName = dict["name"] as? String {
                  country.append(countryName)
                }
                
            }
            self.interestedCountry = country.joined(separator: ",")
        }
          if let year              = data["interested_year"] as? String {
            self.year = year
        }
        if let categoryArr          = data["interested_category_title"] as? [String], let category = categoryArr.first {
            self.category = category
        }
          if let intake            = data["course_intake"] as? String {
            self.intake = intake
        }
          if let courseType        = data["apply_course_type_title"] as? String {
            self.courseType = courseType
        }
          if let qrCode = data["unica_student_code"] as? String{
            self.qrCode = qrCode
        }
    }
   
    
}


/*
 
 "Payload": {
   
   
   
   "unica_student_code": "RYTVV",
   "interested_country": [
     "5",
     "8"
   ],
   "interested_country_title": [
     {
       "id": "5",
       "name": "American Samoa"
     },
     {
       "id": "8",
       "name": "Anguilla"
     }
   ],
   "interested_year": "2021",
   "interested_category_id": [
     "5"
   ],
   "interested_category_title": [
     "Chemical Engineering"
   ],
  
 
 */
