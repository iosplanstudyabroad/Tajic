//
//  eventModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 11/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class eventModel: NSObject {
    var eventId = ""
    var eventName = ""
    var id = ""
    var budgetTitle = ""
    var name = ""
    convenience init(with dict:[String:Any]) {
        self.init()
        if let id = dict["id"] as? String {
            self.id = id
        }
        
        if let id = dict["id"] as? Int {
            self.id = String(id)
        }
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let name = dict["name"] as? String {
        self.eventName = name
        }
        if let budgetTitle = dict["title_budget"] as? String {
            self.budgetTitle = budgetTitle
        }
        
        if let budgetTitle = dict["title_budget"] as? String {
            self.eventName = budgetTitle
        }
        
        if let eventId = dict["event_id"] as? String {
            self.eventId = eventId
        }
        
        if let eventId = dict["event_id"] as? Int {
            self.eventId = String(eventId)
        }
        
        if let eventName = dict["event_name"] as? String {
            self.eventName = eventName
        }
    }
}
