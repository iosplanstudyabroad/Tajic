//
//  TimeLineInterNalCell.swift
//  CampusFrance
//
//  Created by UNICA on 18/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class TimeLineInterNalCell: UITableViewCell {
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var details:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model:TimeLineModel){
        self.name.text    = model.name
        self.details.text = model.details
    }

}
