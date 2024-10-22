//
//  ProfileEnquiryInfoCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ProfileEnquiryInfoCell: UITableViewCell {
    @IBOutlet var courseApplied: UILabel!
   // @IBOutlet var intake: UILabel!
    @IBOutlet var country: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

     func configure(_ model:ProfileEnquiryModel){
        self.courseApplied.text = model.courseType
       // self.intake.text = model.intake
        self.country.text = model.interestedCountry
       }

}
