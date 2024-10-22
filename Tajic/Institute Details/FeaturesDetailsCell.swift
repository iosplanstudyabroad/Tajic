//
//  FeaturesDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class FeaturesDetailsCell: UITableViewCell {
    @IBOutlet var logo: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    
    @IBOutlet var value: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:FeaturesModel){
        self.layoutIfNeeded()
        self.title.text = "\(model.title) : "
        self.value.text = model.value
        if model.logo.isEmpty == false && model.logo.isValidURL {
            if let url = URL(string: model.logo) {
                self.logo.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
