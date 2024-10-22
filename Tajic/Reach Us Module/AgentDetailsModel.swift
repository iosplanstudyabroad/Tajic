//
//  AgentDetailsModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class AgentDetailsModel: NSObject {
 var  id           = ""
 var  name         = ""
 var mobileNumber  = ""
 var phoneNumber   = ""
 var email         = ""
 var address       = ""
 var googleMapLink = ""
 var designation   = ""
 var googlePlusUrl = ""
    
    convenience init(with data:[String:Any]) {
        self.init()
        if let id            = data["id"] as? String {
            self.id = id
        }
        if let name          = data["name"] as? String {
            self.name = name
        }
        if let mobileNumber  = data["mobile_number"] as? String {
            self.mobileNumber = mobileNumber
        }
        if let phoneNumber   = data["directPhoneNumber"] as? String {
            self.phoneNumber = phoneNumber
        }
        if let email         = data["contact_email"] as? String {
            self.email = email
        }
        if let address       = data["address"] as? String {
            self.address = address
        }
        if let googleMapLink = data["google_map_link"] as? String {
            self.googleMapLink = googleMapLink
        }
        if let designation   = data["designation"] as? String {
            self.designation = designation
        }
        if let googlePlusUrl = data["googlePlusUrl"] as? String {
            self.googlePlusUrl = googlePlusUrl
        }
    }
}
