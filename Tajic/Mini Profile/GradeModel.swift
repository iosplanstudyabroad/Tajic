//
//  GradeModel.swift
//  CampusFrance
//
//  Created by UNICA on 24/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GradeModel: NSObject {
    var courseId   = ""
    var courseName = ""
    var gardeSubMenu = [GradeMenuModel]()
    var isSelected  = false
    var subMenuHeight:Int{
        return gardeSubMenu.count * 52
    }
    convenience init(With data:[String:Any]) {
        self.init()
        if let courseId           = data["id"] as? String {
            self.courseId         = courseId
        }
        if let courseName          = data["name"] as? String {
            self.courseName        = courseName
        }
        
        if let array = data["divisions"] as? [[String:Any]] {
            array.forEach { (dict) in
                let model = GradeMenuModel(With:dict)
                gardeSubMenu.append(model)
            }
        }
    }
    
    
    
    
    
}
