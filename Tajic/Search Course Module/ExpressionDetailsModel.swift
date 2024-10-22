//
//  ExpressionDetailsModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
class ExpressionDetailsModel:NSObject {
    var actionId   = ""
    var categoryId = ""
    var isStudent  = ""
    var remarks    = ""
    var templateId  = ""
    convenience init(with param:[String:Any]) {
        self.init()
        if let actionId = param["action"] as? String {
            self.actionId = actionId
        }
        
        if let categoryId = param["category"] as? String {
            self.categoryId = categoryId
        }
        if let isStudent = param["is_student"] as? String {
            self.isStudent = isStudent
        }
       
        
        if let remarks = param["remarks"] as? String {
            self.remarks = remarks
        }
        if let templateId = param["template_id"] as? String {
            self.templateId = templateId
        }
    }
}
