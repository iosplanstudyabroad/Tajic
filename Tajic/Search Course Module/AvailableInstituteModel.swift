//
//  AvailableInstituteModel.swift
//  CampusFrance
//
//  Created by UNICA on 05/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class AvailableInstituteModel: NSObject {
    var participantType = ""
    var participantId   = ""
    var name            = ""
    var id              = ""
    var instituteName   = ""
    var address         = ""
    var city            = ""
    var state           = ""
    var aboutInstitute  = ""
    var slotDate        = ""
    var slotNumber      = ""
    var designation     = ""
    var email           = ""
    var phoneNumber     = ""
    var mobileNumber    = ""
    var webSite         = ""
    var logo           = ""
    var country        = ""
    var expressionDetails = ExpressionDetailsModel()
    var aboutInstituteRowHeight:CGFloat{
       // let str = aboutInstitute.htmlToString
        return  aboutInstitute.heightForHtmlString(font: UIFont.systemFont(ofSize: 16), width: UIScreen.main.bounds.width-20)
    }
    var scanCount = ""
    var buttons    = [InterViewButtonModel]()
    convenience init(with dict:[String:Any]) {
        self.init()
       
        if let expMode = dict[""] as? [String:Any] {
            let model = ExpressionDetailsModel(with: expMode)
            expressionDetails = model
        }
        if let participantType   = dict["participant_type"] as? String{
            self.participantType = participantType
        }
        if let participantId     = dict["participant_id"] as? String{
            self.participantId   = participantId
        }
        
        if let name              = dict["name"] as? String{
            self.name            = name
        }
        if let id                = dict["id"] as? String{
            self.id              = id
        }
        
        if let instituteName     = dict["institute_name"] as? String{
            self.instituteName   = instituteName
        }
        
        if let address           = dict["address"] as? String{
            self.address         = address
        }
        
        if let city              = dict["city"] as? String{
            self.city            = city
        }
        
        if let state             = dict["state"] as? String{
            self.state           = state
   
        }
        if let aboutInstitute             = dict["about_institute"] as? String{
            self.aboutInstitute           = aboutInstitute
        }
        
        if let aboutInstitute             = dict["about"] as? String{
                   self.aboutInstitute           = aboutInstitute
               }
        
        if let slotDate             = dict["slot_name"] as? String{
            self.slotDate           = slotDate
            
        }
        if let slotNumber             = dict["slot_number"] as?  NSNumber{
            self.slotNumber           = "Meeting Slot - \(String(describing:slotNumber))"
        }
        
        
        if let designation = dict["designation"] as? String {
            self.designation = designation
        }
        if let email = dict["email"] as? String {
            self.email = email
        }
        if let phoneNumber = dict["phone"] as? String {
            self.phoneNumber = phoneNumber
        }
        
        if let mobileNumber = dict["mobile"] as? String {
            self.mobileNumber = mobileNumber
        }
        if let webSite = dict["website"] as? String {
            self.webSite = webSite
        }
        
        if let logo = dict["logo"] as? String {
            self.logo = logo
        }
        if let logo = dict["institute_image"] as? String {
            self.logo = logo
        }
        
        if let  countryName = dict["location"] as? String {
             self.country = countryName
        }
        
        if let  countryDetails = dict["country_name"] as? [String:Any]
             {
                if let countryName = countryDetails["short_name"] as? String  {
                  self.country = countryName
                }
          
        }
        
        if let  countryDetails = dict["country_detail"] as? [String:Any]
        {
            if let countryName = countryDetails["short_name"] as? String  {
                self.country = countryName
            }
            
        }
        
        if let scanCount = dict["group_count"] as? String {
            self.scanCount = scanCount
        }
        
        
        if let scanCount = dict["group_count"] as? Int {
            self.scanCount = String(scanCount)
        }
        //about_institute
        if let buttonArray = dict["buttons"] as? [[String:Any]] {
            buttonArray.forEach { (dict) in
            let model = InterViewButtonModel(with: dict)
                self.buttons.append(model)
            }
        }
}
    
}

