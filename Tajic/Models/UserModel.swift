//
//  UserModel.swift
//  CampusFrance
//
//  Created by UNICA on 17/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit


class UserModel: Codable {
    var id               = ""
    var userType         = ""
    var city             = ""
    var dateOfBirth      = ""
    var firstname        = ""
    var lastname         = ""
    var email            = ""
    var mobile           = ""
    var gender           = ""
    var countryId        = ""
    var profileCompleted = ""
    var countryCode      = ""
    var profileImage     = ""
    var eventName        = ""
    var eventId          = ""
    var eventCity        = ""
    var eventdate        = ""
    var countryName      = ""
    var eventLatitude    = ""
    var eventLongitude   = ""
    var agentId          = ""
    var tabDetails       = CourseTabModel()
    convenience init(With data:[String:Any]) {
        self.init()
        if let firstname          = data["firstname"] as? String{
            self.firstname        = firstname
        }
        if let lastname           = data["lastname"] as? String{
            self.lastname         = lastname
        }
        if let dateOfBirth        = data["dob"] as? String {
            self.dateOfBirth      = dateOfBirth
        }
        if let gender             = data["gender"] as? String {
            self.gender           = gender
        }
        if  let email             = data["email"] as? String{
            self.email            = email
        }
        if let city               = data["city"] as? String {
            self.city             = city
        }
        if let countryCode        =  data["country_code"] as? String{
            self.countryCode      =  countryCode
        }
        if let countryId          =  data["country_id"] as? String{
            self.countryId        = countryId
        }
        if let countryName        =  data["country_name"] as? String{
            self.countryName      = countryName
        }
        if  let profileCompleted  = data["profile_completed"] as? String {
            self.profileCompleted = profileCompleted
        }
        if let eventId            = data["event_id"] as? String {
            self.eventId          = eventId
        }
        if let id                 = data["id"] as? String {
            self.id               = id
        }
        
        
        if let id                 = data["userid"] as? String {
                   self.id               = id
               }
        if let profileImage       = data["profile_image"] as? String {
            self.profileImage     = profileImage
        }
        if let mobile             = data["mobile_number"] as? String{
            self.mobile           = mobile
        }
    
        if let userType           = data["user_type"] as? String {
            self.userType         = userType
        }
        if let eventName          = data["event_name"] as? String {
            self.eventName        = eventName
        }
        
        
        
        if let eventName          = data["event_name"] as? String {
            self.eventName        = eventName
        }
        
        if let eventCity          = data["event_city"] as? String {
            self.eventCity        = eventCity
        }
        
        if let eventdate          = data["event_date"] as? String {
            self.eventdate        = eventdate
        }
        
        if let agentId = data["app_agent_id"] as? String {
            self.agentId = agentId
        }
        
        if let agentId = data["app_agent_id"] as? Int{
            self.agentId = String(agentId)
        }
        
        /*
         "event_city" = Mumbai;
         "event_date" = "2019-10-01";
         */
    }
    
    static func getObject() -> UserModel {
        if let data = UserDefaults.standard.data(forKey: UDConst.UserModel) {
            guard let user = try? JSONDecoder().decode(UserModel.self, from: data) else {
                return UserModel()
            }
            return user
        }
        return UserModel()
    }
    //===========================================================
    //MARK: - Saved Object in UserDefault
    //===========================================================
    func saved() {
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(self) else {
            return
        }
        UserDefaults.standard.set(jsonData, forKey: UDConst.UserModel)
        UserDefaults.standard.synchronize()
    }
    
   static func clear(){
        UserDefaults.standard.removeObject(forKey: UDConst.UserModel)
        UserDefaults.standard.synchronize()
    }
}
