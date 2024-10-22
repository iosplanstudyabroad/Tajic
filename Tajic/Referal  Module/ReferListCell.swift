//
//  ReferListCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReferListCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var mobile:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    func configure(_ model:ReferStudentModel){
        
        self.name.text   = "Name  : \(model.name)"
        self.email.text  = "Email : \(model.email)"
        self.mobile.text = "Phone : \(model.mobileNumber)"
    }
}
