//
//  ReachUsModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReachUsModel: NSObject {
var agentModel    = AgentDetailsModel()
var branchesList = [BranchModel]()
    convenience init(_ data:[String:Any]) {
        self.init()
        if let agent = data["agent"] as? [String:Any] {
            let model = AgentDetailsModel(with: agent)
            self.agentModel = model
        }
        if let branchAddArray = data["branch"] as? [[String:Any]],branchAddArray.isEmpty == false{
            branchAddArray.forEach { (dict) in
              let model = BranchModel(with: dict)
                self.branchesList.append(model)
            }
        }
    }
}
