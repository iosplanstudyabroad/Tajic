//
//  MiniProfileCommonModel.swift
//  CampusFrance
//
//  Created by UNICA on 28/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class MiniProfileCommonModel: NSObject {
    var step1Model: StepOneModel?
    var step2Model:StepTwoModel?
    var step3Model:StepThreeModel?
    convenience init(model1:StepOneModel?,model2:StepTwoModel?,model3:StepThreeModel?) {
        self.init()
        if let model         = model1 {
            self.step1Model  = model
        }
        if let model         = model2 {
             self.step2Model = model
        }
        if let model         = model3 {
            self.step3Model  = model
        }
       
       
    }
}
