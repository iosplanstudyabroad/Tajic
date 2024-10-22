//
//  CountryFilterCell.swift
//  Aliff
//
//  Created by Mohit Kumar  on 24/07/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CountryFilterCell: UITableViewCell {
    
    @IBOutlet var card: UIView!
    @IBOutlet weak var menu:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   
    func configure(_ model:CountryModel){
        self.menu.text = model.name
        self.layoutIfNeeded()
    }
}
