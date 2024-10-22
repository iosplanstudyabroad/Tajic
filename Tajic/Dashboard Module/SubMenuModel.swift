//
//  SubMenuModel.swift
//  CampusFrance
//
//  Created by Mohit Kumar on 01/07/19.
//  Copyright © 2019 Mohit Kumar. All rights reserved.
//

import UIKit

class SubMenuModel: NSObject,Codable  {
    var leftMenuTitle       = ""
    var linkOpenType        = "" // A = open in device and w is open in web
    var visibleOnDashBoard  = false
    var rowNumber           = -1 // action
    var leftMenuIconUrl =  ""
    var dashBoardIconUrl    = ""
    var url = ""
    convenience  init(with data:[String:Any]) {
        self.init()
        if let name = data["name"] as? String{
            self.leftMenuTitle = name
        }
        if let  linkOpen = data["type"] as? String {
            switch linkOpen {
            case "W": self.linkOpenType = "Web"
            default: self.linkOpenType = "Device"
            }
            
        }
        if let visible = data["dashboard"] as? String,visible.isEmpty == false {
            self.visibleOnDashBoard = visible.toBool()!
        }
        if let row = data["action"] as? Int {
            self.rowNumber = row
        }
        if let icon = data["icon"] as? String{
            self.leftMenuIconUrl = icon
        }
        
        if let dashIcon = data["icon_colored"] as? String{
            self.dashBoardIconUrl = dashIcon
        }
        
        if let url = data["url"] as? String{
          self.url = url
        }
        }
    }

