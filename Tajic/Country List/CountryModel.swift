//
//  CountryModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 12/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CountryModel: NSObject {
    var id = ""
    var name = ""
    var image = ""
    var url = ""
    convenience init(with data:[String:Any]) {
        self.init()
        if let id = data["id"] as? String {
            self.id = id
        }
        if let id = data["country_id"] as? String {
            self.id = id
        }
        if let name = data["name"] as? String {
            self.name = name
        }
        if let image = data["country_image"] as? String{
            self.image = image
        }
        if let url = data["link_url"] as? String {
            self.url = url 
        }
    }
}
