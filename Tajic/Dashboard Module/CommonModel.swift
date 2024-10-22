//
//  CommonModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 12/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
class commonModel:NSObject {
    var id = ""
    var name = ""
    convenience init(with data:[String:Any]) {
        self.init()
        if let id = data["id"] as? String{
            self.id = id
        }
        if let id = data["id"] as? Int {
            self.id = String(describing: id)
        }
        
        if let id = data["event_id"] as? String{
            self.id = id
        }
        if let id = data["event_id"] as? Int {
            self.id = String(describing: id)
        }
        
        if let name = data["name"] as? String{
            self.name = name
        }
        
        if let name = data["event_name"] as? String{
            self.name = name
        }
    }
}
