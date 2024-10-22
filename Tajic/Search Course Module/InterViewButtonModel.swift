//
//  InterViewButtonModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class InterViewButtonModel: NSObject {
    var name = ""
    var type = ""
    var status = ""
    var action = -1
    convenience init(with data:[String:Any]) {
        self.init()
//        classNameAsString(obj:data["name"]! )
//        classNameAsString(obj:data["type"]! )
//        classNameAsString(obj:data["status"]! )
//        classNameAsString(obj:data["action"]! )
        
        if let name = data["name"] as? String{
           self.name = name
        }
        
        if let type = data["type"] as? NSNumber{
            self.type = String(describing: type)
        }
        
        if let status = data["status"] as? NSNumber{
            self.status = String(describing: status)
        }
        
        if let action = data["action"] as? NSNumber{
            self.action = Int(truncating: action)
        }
        
    }
}
