//
//  GradeMenuModel.swift
//  CampusFrance
//
//  Created by UNICA on 24/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GradeMenuModel: NSObject {
    var gradeId   = ""
    var gradeName = ""
    var isSelected = false
    convenience init(With data:[String:Any]) {
        self.init()
        if let gradeId           = data["id"] as? String {
            self.gradeId         = gradeId
        }
        if let gradeName          = data["name"] as? String {
           self.gradeName   = gradeName
        }
    }
    
}

