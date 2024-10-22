//
//  InfoCell.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
class InfoCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var foundedIn: UILabel!
    @IBOutlet var establishment: UILabel!
    @IBOutlet var institutionType: UILabel!
    @IBOutlet var estimatedCostOfLiving: UILabel!
    @IBOutlet var totalStudents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        foundedIn.text             = model.founded
        establishment.text         = model.establish
        institutionType.text       = model.instituteType
        estimatedCostOfLiving.text = model.estimateCost
        totalStudents.text         = String(model.totalStudents)
    }
}
