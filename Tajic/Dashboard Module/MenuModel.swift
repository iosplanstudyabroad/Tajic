//
//  MenuModel.swift
//  CampusFrance
//
//  Created by Mohit Kumar on 01/07/19.
//  Copyright © 2019 Mohit Kumar. All rights reserved.
//

import UIKit

class MenuModel: NSObject,Codable {
 var leftMenuTitle      = ""
 var linkOpenType       = "" // A= open in device and w is open in web
 var visibleOnDashBoard = false
 var rowNumber          = -1 // action
 var leftMenuIconUrl    =  ""
 var dashBoardIconUrl   = ""
 var isSelected         = false
 var url                = ""
 var visibleOnSlider    = false
 var subMenu            = [SubMenuModel]()
 var dashBoardOrder     = Int()
 var leftMenuOrder      = Int()
 var section            = Int()
    
    convenience init(with data:[String:Any]) {
     self.init()
        if let dashBoardOrder    = data["dashboard_order"] as? Int {
            self.dashBoardOrder = dashBoardOrder
        }
        
        if let leftMenuOrder    = data["navigation_order"] as? Int {
            self.leftMenuOrder = leftMenuOrder
        }
        
        
        if let name = data["name"] as? String{
            self.leftMenuTitle = name
        }
        if let  linkOpen = data["type"] as? String {
            switch linkOpen {
            case "W": self.linkOpenType = "Web"
            default: self.linkOpenType = "Device"
            }
            
        }
        if let visible = data["dashboard"] as? String  {
            if visible == "Y" {
              self.visibleOnDashBoard = true
            }
            if visible == "N" {
                self.visibleOnDashBoard = false
            }
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
        if let navigation = data["navigation"] as? String{
            if navigation == "Y" {
             self.visibleOnSlider  = true
            }
        }
        if let subMenu = data["sub_menus"] as? [[String:Any]] {
            subMenu.forEach { (dict) in
               let model = SubMenuModel(with:dict )
              self.subMenu.append(model)
            }
        }
    }
}

