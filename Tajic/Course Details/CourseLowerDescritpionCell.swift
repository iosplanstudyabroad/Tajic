//
//  CourseLowerDescritpionCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseLowerDescritpionCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    var dataModel = CourseDetailsModel()
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(model: CourseDetailsModel){
        descLabel.textColor = UIColor.darkGray
       descLabel.text =  model.desc.htmlToString
    }

}

