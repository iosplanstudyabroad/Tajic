//
//  LatestEventModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class LatestEventModel: NSObject {
   var cityId        = ""
   var eventDate     = ""
   var eventId       = ""
   var eventImage    = ""
   var eventLocation = ""
   var eventName     = ""
   var isRegistered  = false
   var latitude      = ""
   var longitude     = ""
   var time          = ""
   var desc          = ""
    var bannerArray = [BannerModel]()
    convenience init(with data:[String:Any]) {
        self.init()
        if let cityId          = data["city_id"] as? String  {
            self.cityId        = cityId
        }
        if let eventDate       = data["event_date"] as? String {
            self.eventDate     = eventDate
        }
        if let eventId         = data["event_id"] as? String {
            self.eventId       = eventId
        }
        if let eventId         = data["event_id"] as? Int {
            self.eventId       = String(eventId)
        }
        if let eventImage      = data["event_image"] as? String {
            self.eventImage    = eventImage
        }
        if let eventLocation   = data["event_location"] as? String {
            self.eventLocation = eventLocation
        }
        if let eventName       = data["event_name"] as? String {
            self.eventName     = eventName
        }
        if let  isRegistered   = data["isRegistered"] as? Bool {
            self.isRegistered  = isRegistered
        }
        if let latitude        = data["latitude"] as? String {
            self.latitude      = latitude
        }
        if let  longitude      = data["longitude"] as? String {
            self.longitude     = longitude
        }
        if let time            = data["time"] as? String{
            self.time          = time
        }
        if let desc            = data["description"] as? String {
            self.desc          = desc
        }
        
        if let banArray = data["event_banners"] as? [[String:Any]] {
            if banArray.isEmpty {
                let model = BannerModel()
                if let url = data["event_image"] as? String {
                 model.showBannerUrl = url
                    bannerArray.append(model)
                }
                
            }else{
                banArray.forEach { (dict) in
                    let model = BannerModel(with:dict)
                    bannerArray.append(model)
                }
            }
        }
    }
}




/*
 {
     
     description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Afghanistan.";
     "event_banners" =                 (
                             {
             "add_date" = "2020-03-24 11:26:16";
             "agent_id" = 17;
             "banner_id" = 31;
             "banner_url" = "https://www.uniagentscrm.com/agent-crm-dev/app_banners/17_app_banner_24032020112616.jpg";
             "counsellor_id" = "<null>";
             "event_id" = 1;
             id = 31;
             image = "17_app_banner_24032020112616.jpg";
             "link_url" = "";
             status = Y;
             "update_date" = "2020-03-24 11:26:16";
         }
     );
     time = "10:00:00";
 }
 */
