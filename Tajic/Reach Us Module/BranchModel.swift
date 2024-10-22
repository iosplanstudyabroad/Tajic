//
//  BranchModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
class BranchModel: NSObject {
 var id                  = ""
 var branchType          = ""
 var name                = ""
 var phoneNumber         = ""
 var address             = ""
 var googleMapLink       = ""
 var latitude:Double     = 0
    var longitude:Double = 0
    convenience init(with data:[String:Any]) {
        self.init()
        if let  id             = data["id"] as? String {
            self.id            = id
        }
        if let branchType      = data["branch_type"] as? String {
           self.branchType     = branchType
        }
        if let name            = data["name"] as? String {
          self.name            = name
        }
        if let phoneNumber     = data["phone_number"] as? String {
           self.phoneNumber    = phoneNumber
        }
        if let address         = data["address"] as? String {
            self.address       = address
        }
        if let googleMapLink   = data["google_map_link"] as? String {
            self.googleMapLink = googleMapLink
        }
        if let long = data["longitude"] as? String,long.isEmpty == false {
            self.longitude = Double(long)!
        }
        
        if let lat = data["latitude"] as? String,lat.isEmpty == false  {
            self.latitude = Double(lat)!
        }
    }
}



