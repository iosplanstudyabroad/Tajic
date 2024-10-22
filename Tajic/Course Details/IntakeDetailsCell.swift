//
//  IntakeDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class IntakeDetailsCell: UITableViewCell {
    @IBOutlet weak var title:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:CourseIntakeModel){
        print(model.intakeDeadlineMonth)
        self.title.text = model.intakeMonth
    }
  
}
