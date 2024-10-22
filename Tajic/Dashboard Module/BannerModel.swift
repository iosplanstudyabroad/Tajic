//
//  BannerModel.swift
//  CampusFrance
//
//  Created by UNICA on 11/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class BannerModel: NSObject {
    var showBannerUrl = ""
    var openLink      = ""
    var bannerId      = ""
    convenience init(with dict:[String:Any]) {
        self.init()
        
        if let bannerId = dict["banner_id"] as? String {
         self.bannerId = bannerId
        }
        
        if let bannerId = dict["banner_id"] as? Int {
            self.bannerId =  String(describing:bannerId)
            
        }
        
        if let showBannerUrl = dict["banner_url"] as? String {
          self.showBannerUrl = showBannerUrl
        }
        if let openLink = dict["link_url"] as? String {
           self.openLink = openLink
        }
        
        
    }
}


 
