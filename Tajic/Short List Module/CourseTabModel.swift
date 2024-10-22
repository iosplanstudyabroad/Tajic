//
//  CourseTabModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 04/04/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CourseTabModel: NSObject, Codable {
   var featuredTitle   = ""
   var isShowTabs      = false
   var isFeaturedTitle = false
   var isMatchTitle    = false
   var matchTitle      = ""
   var message         = ""
    convenience init(_ data:[String:Any]) {
        self.init()
        if let featuredTitle     = data["featured_title"] as? String {
           self.featuredTitle    = featuredTitle
        }
        if let isShowTabs        = data["is_display_tabs"] as? Bool {
           self.isShowTabs       = isShowTabs
        }
        if let isFeaturedTitle   = data["is_featured_title"]as? Bool {
            self.isFeaturedTitle = isFeaturedTitle
        }
        if let isMatchTitle      = data["is_match_title"]as? Bool {
            self.isMatchTitle    = isMatchTitle
        }
        if let matchTitle        = data["match_title"] as? String {
            self.matchTitle      = matchTitle
        }
        if let message           = data["message"] as? String {
            self.message         = message
        }
    }
}
