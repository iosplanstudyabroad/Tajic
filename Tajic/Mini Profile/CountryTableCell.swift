//
//  CountryTableCell.swift
//  CampusFrance
//
//  Created by UNICA on 17/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CountryTableCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
