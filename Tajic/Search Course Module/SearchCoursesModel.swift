//
//  SearchCoursesModel.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SearchCoursesModel: NSObject {
    var id = ""
    var courseTitle = ""
    var instituteId    = ""
    var instituteName  = ""
    var courseFee      = ""
    var applicationFee = ""
    var courseCountry  = ""
    var scholarShip    = ""
    var logo           = ""
    var isLike         = true
    var participantId  = ""
    var participantType = ""
    var courseId       = ""
    var appFee         = ""
    var isShowCourse   = false
    var isFromFeature  = false
    convenience  init(with data:[String:Any]) {
     self.init()
        if let id = data["id"] as? String{
         self.id = id
        }
        if let title = data["title"] as? String{
            self.courseTitle = title
        }
        if let instId = data["institute_id"] as? String{
            self.instituteId = instId
        }
        if let instName = data["institute_name"] as? String{
            self.instituteName = instName
        }
        if let fee = data["course_fee"] as? String{
            self.courseFee = fee
        }
        if let appFee = data["application_fee"] as? String{
            self.applicationFee = appFee
        }
        
        if let fee = data["converted_amount_tution_fee"] as? String{
            self.applicationFee = fee
        }
        
        if let courseCountry = data["course_country"] as? String{
            self.courseCountry = courseCountry
        }
        if let scholarship = data["scholarship"] as? String{
            self.scholarShip = scholarship
        }
        if let logo = data["logo"] as? String{
            self.logo = logo
        }
        
        if let participantId = data["participant_id"] as? String{
            self.participantId = participantId
        }
        if let participantType = data["participant_type"] as? String{
            self.participantType = participantType
        }
        
        
        
        if let likeStatus = data["is_like"] as? Bool{
            self.isLike = likeStatus
        }
        
        if let courseDetail = data["course_detail"] as? [String:Any]{
            if  let courseId = courseDetail["id"] as? String {
               self.courseId = courseId
            }
            
            if  let appFee = courseDetail["application_fee"] as? String {
                self.appFee   = appFee
            }
        }
    }
}



