//
//  stepOneModel.swift
//  CampusFrance
//
//  Created by UNICA on 27/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class StepOneModel: NSObject {
    var  isCompleted       = ""
    var highEducationName  = ""
    var highEducationId    = -1
    var instName           = ""
    var coutryId           = -1
    var gradeId            = -1
    var subgradeId         = -1
    var subgradePercentage = ""
    override init() {
        self.isCompleted        = ""
        self.highEducationName  = ""
        self.highEducationId    = -1
        self.coutryId           = -1
        self.gradeId            = -1
        self.subgradeId         = -1
        self.instName           = ""
        self.subgradePercentage = ""
    }
}
