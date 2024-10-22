//
//  EligibilityCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class EligibilityCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
   
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(model: CourseDetailsModel){
        descLabel.textColor = UIColor.darkGray
       descLabel.text =  model.eligibility
    }

}
