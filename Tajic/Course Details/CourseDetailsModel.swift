//
//  ProfileDetailsModel.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseDetailsModel: NSObject /* {
    var id                = ""
    var title             = ""
    var instituteId       = ""
    var instituteName     = ""
    var courseLevel       = ""
    var courseCategory    = ""
    var courseSubCategory = ""
    var desc              = ""
    var duration          = ""
    var processingTime    = ""
    var country           = ""
    var countryFlag       = ""
    var logo              = ""
    var programmeName     = ""
    var interested        = ""
    var courseIntakeArray = [CourseIntakeModel]()
    var charge             = ChargeModel()
    var isLike            = false
    var applicationFee   = "0"
    var livingCost  = ""
    var tutionFee   = ""
    var tutionFeeBreakup = ""
  
    var timeLineArray = [TimeLineModel]()
    var eligibility    = ""
    var otherRequirements = ""
    var specialInstructions  = ""
    
    

    
    
    var intakeHeight:CGFloat{
        let array =  courseIntakeArray
        var str = ""
        array.forEach { (iModel) in
            str +=   iModel.courseMonthDeadline + "\n"
        }
        let height = str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
        if height < 100{
            return 250
        }
        return str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
    }
    var descriptionRowHeight:CGFloat{
        let str = desc.htmlToString
      return  str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
    }
    
    convenience init(with data:[String:Any]) {
       self.init()
        if let id = data["id"] as? String{
           self.id = id
        }
        if let title = data["title"] as? String{
            self.title = title
        }
        if let instituteId = data["institute_id"] as? String{
            self.instituteId = instituteId
        }
        
        if let instituteName = data["institute_name"] as? String{
            self.instituteName = instituteName
        }
        
        if let courseLevel = data["course_level"] as? String{
            self.courseLevel = courseLevel
        }
       
        if let courseCategory = data["course_category"] as? String{
            self.courseCategory = courseCategory
        }
        
        if let courseSubCategory = data["course_sub_category"] as? String{
           self.courseSubCategory = courseSubCategory
        }
        
        if let desc = data["description"] as? String{
            self.desc = desc
        }
    
        if let duration = data["duration"] as? String{
            self.duration = duration
        }
        if let processingTime = data["processing_time"] as? String{
            self.processingTime = processingTime
        }
        if let country = data["country"] as? String{
            self.country = country
        }
        if let countryFlag = data["country_flag"] as? String{
            self.countryFlag = countryFlag
        }
        if let logo = data["logo"] as? String{
            self.logo = logo
        }
        if let programmeName = data["programme"] as? String{
            self.programmeName = programmeName
        }
        if let interested = data["interested"] as? String{
            self.interested = interested
        }
        
        if let courseIntakeArray =  data["course_intakes"] as? [[String:Any]] {
            courseIntakeArray.forEach { (dict) in
                let model = CourseIntakeModel(with: dict)
                self.courseIntakeArray.append(model)
            }
        }
       
        if let charge = data["charges"] as? [String:Any]{
            let model = ChargeModel(with: charge)
            self.charge = model
        }
        if let isLike = data["is_like"] as? Bool {
            self.isLike = isLike
        }
        
        if let applicationFee = data["application_fee"] as? String {
            if applicationFee.contains("(") {
                
            }
            self.applicationFee = applicationFee
        }
       
        
        if let duration = data["duration"] as? String {
            self.duration = duration
        }
        
        if let livingCost =  data["living_cost"] as? String {
            self.livingCost = livingCost
        }
        
        if let tutionFee =  data["tution_fee"] as? String {
            self.tutionFee = tutionFee
        }
        
        if let tutionFeeBreakup =  data["tution_fee_breakup"] as? String {
            self.tutionFeeBreakup = tutionFeeBreakup
        }
      
        
        if let eligibility =  data["eligibility_domestic_student"] as? String {
            self.eligibility = eligibility
        }
        
        
        if let otherRequirements =  data["other_admission_requirement"] as? String {
            self.otherRequirements = otherRequirements
        }
        
        
        if let specialInstructions =  data["special_appl_instructions"] as? String {
            self.specialInstructions = specialInstructions
        }
        
        if let timeLineArr = data["timeline"] as? [[String:Any]] {
            timeLineArr.forEach { (dict) in
                let model = TimeLineModel(with: dict)
                self.timeLineArray.append(model)
            }
        }
        
    }
}*/






{
    var id                = ""
    var title             = ""
    var instituteId       = ""
    var instituteName     = ""
    var courseLevel       = ""
    var courseCategory    = ""
    var courseSubCategory = ""
    var desc              = ""
    var duration          = ""
    var processingTime    = ""
    var country           = ""
    var countryFlag       = ""
    var logo              = ""
    var programmeName     = ""
    var interested        = ""
    var courseIntakeArray = [CourseIntakeModel]()
    var charge             = ChargeModel()
    var isLike            = false
    var applicationFee   = "0"
    var livingCost  = ""
    var tutionFee   = ""
    var tutionFeeBreakup = ""
  
    var timeLineArray = [TimeLineModel]()
    var eligibility    = ""
    var otherRequirements = ""
    var specialInstructions  = ""
    
   
    
   var courseType = ""
    var isEligible = false
    
    var jobOpportunityPotential = ""
   
    
    var pswpportunity = ""
    
    
    var isApplied = false
    var appliedCount = 0
    
    var languageRequirementArray = [languageModel]()
    
    var accreditationArray = [String]()
    
    var videoArray = [VideoModel]()
    var campusListArray = [CampusModel]()
    
    var intakeHeight:CGFloat{
        let array =  courseIntakeArray
        var str = ""
        array.forEach { (iModel) in
            str +=   iModel.courseMonthDeadline + "\n"
        }
        let height = str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
        if height < 100{
            return 250
        }
        return str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
    }
    var descriptionRowHeight:CGFloat{
        let str = desc.htmlToString
      return  str.heightForHtmlString(font: UIFont.systemFont(ofSize: 17.5), width: UIScreen.main.bounds.width-20)
    }
    
    convenience init(with data:[String:Any]) {
       self.init()
        
        if let charge = data["charges"] as? [String:Any]{
            if let applicationFee = charge["application_fee"] as? String {
                      if applicationFee.contains("(") {
                          
                      }
                      self.applicationFee = applicationFee
                  }
                 
                  
                  if let livingCost =  charge["living_cost"] as? String {
                      self.livingCost = livingCost
                  }
                  
                  if let tutionFee =  charge["tution_fee"] as? String {
                      self.tutionFee = tutionFee
                  }
                  
                  if let tutionFeeBreakup =  charge["tution_fee_breakup"] as? String {
                      self.tutionFeeBreakup = tutionFeeBreakup
                  }
                        }
        
        
        if let id = data["id"] as? String{
           self.id = id
        }
        if let title = data["title"] as? String{
            self.title = title
        }
        if let instituteId = data["institute_id"] as? String{
            self.instituteId = instituteId
        }
        
        if let instituteName = data["institute_name"] as? String{
            self.instituteName = instituteName
        }
        
        if let courseLevel = data["course_level"] as? String{
            self.courseLevel = courseLevel
        }
       
        if let courseCategory = data["course_category"] as? String{
            self.courseCategory = courseCategory
        }
        
        if let courseSubCategory = data["course_sub_category"] as? String{
           self.courseSubCategory = courseSubCategory
        }
        
        if let desc = data["description"] as? String{
            self.desc = desc
        }
    
        if let duration = data["duration"] as? String{
            self.duration = duration
        }
        if let processingTime = data["processing_time"] as? String{
            self.processingTime = processingTime
        }
        if let country = data["country"] as? String{
            self.country = country
        }
        if let countryFlag = data["country_flag"] as? String{
            self.countryFlag = countryFlag
        }
        if let logo = data["logo"] as? String{
            self.logo = logo
        }
        if let programmeName = data["programme"] as? String{
            self.programmeName = programmeName
        }
        if let interested = data["interested"] as? String{
            self.interested = interested
        }
        //intake
        if let courseIntakeArray =  data["course_intakes"] as? [[String:Any]] {
            courseIntakeArray.forEach { (dict) in
                let model = CourseIntakeModel(with: dict)
                self.courseIntakeArray.append(model)
            }
        }
       
        
        if let courseIntakeArray =  data["intake"] as? [[String:Any]] {
            courseIntakeArray.forEach { (dict) in
                let model = CourseIntakeModel(with: dict)
                self.courseIntakeArray.append(model)
            }
        }
        
        
        if let charge = data["charges"] as? [String:Any]{
            let model = ChargeModel(with: charge)
            self.charge = model
        }
        if let isLike = data["is_like"] as? Bool {
            self.isLike = isLike
        }
        
        if let isLike = data["is_like"] as? String,isLike.isEmpty == false  {
            if let like = isLike.toBool() {
             self.isLike = like
            }
            
               }
        
        if let applicationFee = data["application_fee"] as? String {
            if applicationFee.contains("(") {
                
            }
            self.applicationFee = applicationFee
        }
       
        
        if let duration = data["duration"] as? String {
            self.duration = duration
        }
        
        if let livingCost =  data["living_cost"] as? String {
            self.livingCost = livingCost
        }
        
        if let tutionFee =  data["tution_fee"] as? String {
            self.tutionFee = tutionFee
        }
        
        if let tutionFeeBreakup =  data["tution_fee_breakup"] as? String {
            self.tutionFeeBreakup = tutionFeeBreakup
        }
      
        
        if let eligibility =  data["eligibility_domestic_student"] as? String {
            self.eligibility = eligibility
        }
        
        
        if let otherRequirements =  data["other_admission_requirement"] as? String {
            self.otherRequirements = otherRequirements
        }
        
        
        if let specialInstructions =  data["special_appl_instructions"] as? String {
            self.specialInstructions = specialInstructions
        }
        
        if let timeLineArr = data["timeline"] as? [[String:Any]],timeLineArr.isEmpty == false  {
            timeLineArr.forEach { (dict) in
                let model = TimeLineModel(with: dict)
                self.timeLineArray.append(model)
            }
        }
        
        if let courseType  = data["course_type"] as? String {
            self.courseType = courseType
        }
        
        
        if let isEligible = data["is_eligible"] as? Bool {
            self.isEligible = isEligible
        }
        
        if let jobOpportunityPotential = data["job_opportunity_potential"] as? String {
            self.jobOpportunityPotential = jobOpportunityPotential
        }
     
        if let pswOpportunity = data["psw_opportunity"] as? String {
            self.pswpportunity = pswOpportunity
        }
        
        if let isApplied = data["applied"] as? Bool {
            self.isApplied = isApplied
        }
        
        if let appliedCount = data["applied_count"] as? Int {
            self.appliedCount = appliedCount
        }
        
        if let languageArray = data["language_requirement"] as? [[String:Any]] {
            languageArray.forEach { (dict) in
                let model = languageModel(dict)
                self.languageRequirementArray.append(model)
            }
        }
        
        if let accredArray = data["accreditation_organisations"] as? [[String:Any]] {
            accredArray.forEach { (dict) in
                if let key = data["logo"] as? String{
                    self.accreditationArray.append(key)
                }
            }
        }
        
        if let videoArr = data["videos_url"] as? [[String:Any]] {
            videoArr.forEach { (dict) in
                let model = VideoModel(dict)
                self.videoArray.append(model)
            }
        }
        
        if let campusArr = data["campus_list"] as? [[String:Any]] {
            campusArr.forEach { (dict) in
                let model = CampusModel(dict)
                self.campusListArray.append(model)
            }
        }
        
     }
}

class CampusModel: NSObject {
    var name = ""
    var desc = ""
    convenience  init(_ data:[String:Any]) {
        self.init()
        if let name = data["name"] as? String {
            self.name  = name
        }
        if let desc = data["description"] as? String {
            self.desc = desc
        }
    }
}

/*
 in.setTitle(inOb.getString("name"));
                                   in.setInfo(inOb.getString("description"));
 
 */
class languageModel:NSObject {
    var title = ""
    var value = ""
    convenience  init(_ data:[String:Any]) {
        self.init()
        if let title = data["title"] as? String {
            self.title  = title
        }
        if let value = data["value"] as? String {
            self.value = value
        }
    }
}


class TimeLineModel: NSObject{
    var name = ""
    var details = ""
    convenience  init(with data:[String:Any]) {
        self.init()
        if let name = data["name"] as? String {
            self.name = name
        }
        if let details = data["value"] as? String {
            self.details = details
        }
    }
}
