//
//  ExamScoreSubModel.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class ExamScoreSubModel: NSObject {
    var id:String!
    var title:String!
    var value:String!
    var isSelected = false
    convenience init(with data:[String:Any]) {
        self.init()
        if let id = data["id"] as? String {
          self.id    = id
        }
        if let title = data["title"] as? String {
            self.title = title
        }
        if let value = data["value"] as? String {
          self.value = value
        }
    }
    
}
