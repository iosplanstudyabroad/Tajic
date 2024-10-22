//
//  JobOppertunityCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 19/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class JobOppertunityCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    var dataModel = CourseDetailsModel()
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(model: CourseDetailsModel){
        descLabel.textColor = UIColor.darkGray
        descLabel.text =  model.jobOpportunityPotential.htmlToString
    }

}
