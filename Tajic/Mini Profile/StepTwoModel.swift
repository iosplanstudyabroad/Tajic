//
//  StepTwoModel.swift
//  CampusFrance
//
//  Created by UNICA on 28/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class StepTwoModel: NSObject {
    var educationLevelId     = -1
    var applyCourseTypeId    = -1
    var interestedYear       = ""
    var interestedCategoryId = -1
    var interestedSubCategoryId = -1
    
    override init() {
        self.educationLevelId     = -1
        self.applyCourseTypeId    = -1
        self.interestedYear       = ""
        self.interestedCategoryId = -1
    }
}
