//
//  GeneralInfoModel.swift
//  CampusFrance
//
//  Created by UNICA on 10/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GeneralInfoModel {
    var icon = ""
    var link = ""
    var title = ""
    convenience init(with data:[String:Any]) {
        self.init()
       if let icon = data["icon"] as? String{
            self.icon = icon
        }
        
       if let link = data["link"] as? String{
            self.link = link
        }
        
       if let title = data["title"] as? String{
           self.title = title
        }
    }
}
