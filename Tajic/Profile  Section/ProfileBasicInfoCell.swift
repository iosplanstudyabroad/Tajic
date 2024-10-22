//
//  ProfileBasicInfoCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ProfileBasicInfoCell: UITableViewCell {
    @IBOutlet var userIcon: UIImageView!
    @IBOutlet var phoneIcon: UIImageView!
    @IBOutlet var emailIcon: UIImageView!
    
    @IBOutlet var crm: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var mobile: UILabel!
    @IBOutlet var email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ model:ProfileEnquiryModel){
        self.crm.text    = model.agentCrmID 
        self.name.text   = model.firstName + " " + model.lastName
        self.mobile.text = model.mobileNumber
        self.email.text  = model.email
        
        
        let color = UIColor().themeColor()
        
        
        self.userIcon.image = self.userIcon.image?.withRenderingMode(.alwaysTemplate)
        self.userIcon.tintColor = color
        
        self.emailIcon.image = self.userIcon.image?.withRenderingMode(.alwaysTemplate)
        
        self.emailIcon.tintColor = color
        
        self.phoneIcon.image = self.phoneIcon.image?.withRenderingMode(.alwaysTemplate)
        
        self.phoneIcon.tintColor = color
        
    }

}
