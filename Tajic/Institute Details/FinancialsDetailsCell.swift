//
//  FinancialsDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class FinancialsDetailsCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:FinancialModel){
        self.layoutIfNeeded()
        self.title.text = "\(model.title) : "
        self.value.text = model.value
    }
}
