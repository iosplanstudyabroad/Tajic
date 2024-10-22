//
//  GraduationModel.swift
//  CampusFrance
//
//  Created by Mohit on 20/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GraduationModel: NSObject {
    var name         = ""
    var schoolName   = ""
    var subjectName  = ""
    var awardingBody = ""
    var passingYear  = ""
    var marks        = ""
    
    
    convenience init(with data:[String:Any]) {
        self.init()
        if let name = data["degree_name"] as? String{
            self.name = name
        }
        if let schoolName     = data["institution_name"] as? String {
            self.schoolName   = schoolName
        }
        if let subjectName    = data["course_name"] as? String {
            self.subjectName  = subjectName
        }
        if let awardingBody   = data["awarding_body"] as? String {
            self.awardingBody = awardingBody
        }
        if let passingYear    = data["year_of_passing"] as? String {
            self.passingYear  = passingYear
        }
        if let marks          = data["percentage"] as? String {
            self.marks        = marks
        }
    }
    
}
