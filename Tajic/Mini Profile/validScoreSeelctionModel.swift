//
//  validScoreSeelctionModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 12/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class validScoreSeelctionModel:NSObject{
    var index             = -1
    var selectedMenuId    = ""
    var selectedSubMenuId = ""
    var dataDict:[String:String]{
        return ["exam_id":selectedMenuId,"score_id":selectedSubMenuId]
    }
    
}

