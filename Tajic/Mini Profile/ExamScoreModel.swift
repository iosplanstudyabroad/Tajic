//
//  ExamScoreModel.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class ExamScoreModel: NSObject {
    var title = ""
    var id = ""
    var isShowSubMenu = false
    var submodel  = [ExamScoreSubModel]()
    var rowHeight:Int{
        return submodel.count * 50
    }
    convenience init(with data:[String:Any]) {
        self.init()
        if let title = data["title"] as? String {
          self.title = title
        }
        if let id = data["id"] as? String {
        self.id = id
        }
        if let subModelArray = data["inputparameters"] as? [[String:Any]]{
            subModelArray.forEach { (dict) in
                let model = ExamScoreSubModel(with: dict)
                submodel.append(model)
            }
        }
    }
}
