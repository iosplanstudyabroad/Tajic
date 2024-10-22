//
//  ReachUsAgentCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReachUsAgentCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var mobile:UILabel!
    
    var model = AgentDetailsModel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ model:AgentDetailsModel){
        self.name.text = model.name
        self.email.text  = model.email
        self.mobile.text = model.mobileNumber
        self.model = model
    }
    
    
    @IBAction func mobileBtnTapped(_ sender:UIButton){
        if self.model.mobileNumber.isEmpty == false {
      callNumber(phoneNumber:self.model.mobileNumber )
        }
    }
    
    
    
    @IBAction func emailBtnTapped(_ sender:UIButton){
        if let url = URL(string: "mailto:\(self.model.email)") {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    private func callNumber(phoneNumber:String) {
        var number = phoneNumber.replacingOccurrences(of: "+", with: "")
             number = number.replacingOccurrences(of: " ", with: "")
      if let phoneCallURL = URL(string: "tel://\(number)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
}


