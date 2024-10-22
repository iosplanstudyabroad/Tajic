//
//  EducationModel.swift
//  CampusFrance
//
//  Created by UNICA on 24/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseModel: NSObject {
    var courseId   = ""
    var courseName = ""
    var applicationFee = ""
    convenience init(With data:[String:Any]) {
        self.init()
        if let courseId           = data["id"] as? String {
            self.courseId         = courseId
        }
        if let courseName          = data["name"] as? String {
            self.courseName        = courseName
        }
        
        if let courseName          = data["course_name"] as? String {
                   self.courseName        = courseName
               }
        
        
        if let applicationFee          = data["application_fee"] as? String {
            self.applicationFee        = applicationFee
        }
        
    }
    
    
    
    
    /*
     "application_fee" = "120000 KRW";
                "approx_fee" = "120000 ";
                "course_id" = 1135;
                "course_name" = "Korean Language and Literature";
                "is_eligible" = false;
                "tution_fee" = "27016000 KRW";
     */
  
    
    
}
