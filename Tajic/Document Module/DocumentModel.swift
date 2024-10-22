//
//  DocumentModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 17/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class DocumentModel: NSObject {
    var isUploaded     = false
    var url            = ""
    var name           = ""
    var documentTypeId = ""
    var title          = ""
    
    convenience init(with data:[String:Any]) {
        self.init()
        if let status           = data["status"] as? Bool{
           self.isUploaded      = status
        }
        if let url              = data["url"] as? String {
            self.url            = url
        }
        if let name             = data["name"] as? String {
            self.name           = name
        }
        if let docTypeId        = data["document_type_id"] as? String {
            self.documentTypeId = docTypeId
        }
        
        if let docTypeId        = data["document_type_id"] as? Int {
                   self.documentTypeId = String(docTypeId)
               }
        if let title            = data["title"] as? String {
            self.title          = title
        }
    }
}
