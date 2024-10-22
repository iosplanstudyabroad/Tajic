//
//  ApplicationModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 18/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ApplicationModel: NSObject {
  var id           = ""
  var courseName   = ""
  var university   = ""
  var instituteId  = ""
  var status       = ""
  var courseId     = ""
  var countryId    = ""
  var countryName  = ""
  var countryImage = ""
  var isFromFeature = false
  var isShowCourse = false 
    convenience init(_ data:[String:Any]) {
        self.init()
        if let id              = data["id"] as? String {
            self.id            = id
        }
        if let courseName      = data["course_name"] as? String {
            self.courseName    = courseName
        }
        if let university      = data["course_university"] as? String {
            self.university    = university
              }
        if let university      = data["institute_name"] as? String {
        self.university    = university
          }
        
        if let instituteId      = data["institute_id"] as? String {
        self.instituteId       = instituteId
          }
        
        if let status          = data["status"] as? String {
            self.status        = status
              }
        if let courseId        = data["course_id"] as? String {
            self.courseId      = courseId
            }
        if let countryId       = data["country_id"] as? String {
                self.countryId = countryId
            }
        if let countryName     = data["country_name"] as? String {
            self.countryName   = countryName
        }
        if let countryImage    = data["country_image"] as? String {
            self.countryImage  = countryImage
            }
        
        if let status    = data["is_crm_course"] as? String {
            self.isFromFeature = false
            if status == "Y" {
                self.isFromFeature = true
            }
            }
    }
}

