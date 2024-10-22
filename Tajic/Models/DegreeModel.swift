//
//  DegreeModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 11/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class DegreeModel: NSObject {
    var id = ""
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
    }
}
