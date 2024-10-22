//
//  ShortListModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ShortListModel: NSObject {
    var universityName = ""
    var universityId   = ""
    var courseName     = ""
    var fee            = ""
    var appAgentId     = ""
    var courseId       = ""
    var courseImage    = ""
    var isLike         = false
    var isShowCourse   = false
    var isFromFeature  = false 
    convenience init(_ data:[String:Any]) {
        self.init()
        if let  universityName  = data["institute_name"] as? String{
            self.universityName = universityName
        }
        if let  universityId    = data["institute_id"] as? String{
            self.universityId   = universityId
               }
        if let courseName       = data["course_name"] as? String{
            self.courseName     = courseName
        }
        
        if let fee = data["application_fee"] as? String {
            self.fee = fee
        }
        if let appAgentId       = data["app_agent_id"] as? String{
            self.appAgentId     = appAgentId
        }
        if let courseId         = data["course_id"] as? String{
            self.courseId       =  courseId
        }
        if let courseImage      = data["course_image"] as? String{
            self.courseImage    = courseImage
        }
    }
}
