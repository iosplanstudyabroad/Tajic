//
//  CourseLowerDetailsCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseLowerDetailsCell: UITableViewCell {

    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var days: UILabel!
    
    @IBOutlet weak var tutionFee: UILabel!
    
    @IBOutlet weak var applicationFee: UILabel!
    
    @IBOutlet weak var livingCost: UILabel!
    
    @IBOutlet weak var breakUp: UILabel!
    
    @IBOutlet weak var program: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(model:CourseDetailsModel){
        self.year.text           = "Duration:" + model.duration
        self.days.text           = "Average Processing Time:" + model.processingTime
        self.tutionFee.text      =  "Tution Fee:" + model.charge.tutionFee
        self.applicationFee.text = "Application Fee : " + model.charge.appFee
        self.livingCost.text     = "Living Cost:" + model.charge.livingCost
        self.breakUp.text        = "Tution Fee Breakup:" + model.charge.tutionFeeBreakup
        self.program.text        = "Program level:" + model.courseLevel
        //self.program.textColor = UIColor().selectionColor()
    }
}
