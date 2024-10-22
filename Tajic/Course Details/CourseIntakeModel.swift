//
//  CourseIntakeModel.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseIntakeModel: NSObject {
    var id                  = ""
    var institutesCoursesId = ""
    var instituteId         = ""
    var level               = ""
    var intakeMonth         = ""
    var intakeNote          = ""
    var intakeDeadlineMonth = ""
    var intakeDeadlineDay   = ""
    var addDate             = ""
    var updateDate          = ""
    var pushRecord          = ""
    var pushDateLast        = ""
    var pushByUserId        = ""
    var courseMonthDeadline = ""
    
    convenience init(with data:[String:Any]) {
        self.init()
        if let id                    = data["id"] as?String {
            self.id                  = id
        }
        if let institutesCoursesId   = data["institutes_courses_id"] as?String {
            self.institutesCoursesId = institutesCoursesId
        }
        if let instituteId           = data["institute_id"] as?String {
            self.instituteId         = instituteId
        }
        if let level                 = data["level"] as?String {
            self.level               = level
        }
        
        if let intakeMonth           = data["intake_month"] as?String {
            self.intakeMonth         = intakeMonth
        }
        if let intakeMonth           = data["message"] as?String {
            self.intakeMonth         = intakeMonth
        }
        
        //message
        
        if let intakeNote            = data["intake_note"] as?String {
            self.intakeNote          = intakeNote
        }
        
        if let intakeDeadlineMonth   = data["intake_deadline_month"] as?String {
            self.intakeDeadlineMonth = intakeDeadlineMonth
        }
        
        if let intakeDeadlineDay     = data["intake_deadline_day"] as?String {
            self.intakeDeadlineDay   = intakeDeadlineDay
        }
        if let addDate               = data["add_date"] as?String {
            self.addDate             = addDate
        }
        
        if let updateDate            = data["update_date"] as?String {
            self.updateDate          = updateDate
        }
        
        if let pushRecord            = data["push_record"] as?String {
            self.pushRecord          = pushRecord
        }

        if let pushDateLast          = data["push_date_last"] as?String {
            self.pushDateLast        = pushDateLast
        }
    
        if let pushByUserId          = data["push_by_user_id"] as?String {
            self.pushByUserId        = pushByUserId
        }
        
        if let courseMonthDeadline   = data["course_month_deadline"] as?String {
            self.courseMonthDeadline = courseMonthDeadline
        }
    }
}
