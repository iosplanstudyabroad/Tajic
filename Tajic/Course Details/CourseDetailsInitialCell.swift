//
//  CourseDetailsInitialCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 19/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CourseDetailsInitialCell: UITableViewCell {

    @IBOutlet var duration: UILabel!
    
    
    @IBOutlet var averageProcessingTime: UILabel!
    
    
    @IBOutlet var tutionFee: UILabel!
    
    @IBOutlet var applicationFee: UILabel!
    
    @IBOutlet var livingCost: UILabel!
    
    @IBOutlet var tutionFeeBreakUp: UILabel!
    
    
    @IBOutlet var courseType: UILabel!
    
    
    @IBOutlet var programeLevel: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    func configure(_ model:CourseDetailsModel) {
        self.duration.text              = model.duration
        self.averageProcessingTime.text = model.processingTime
        self.tutionFee.text             = model.tutionFee
        self.applicationFee.text        = model.applicationFee
        self.livingCost.text            = model.livingCost
        self.tutionFeeBreakUp.text      = model.tutionFeeBreakup
        self.courseType.text            = model.courseType
        self.programeLevel.text         = model.courseLevel
    }

}
