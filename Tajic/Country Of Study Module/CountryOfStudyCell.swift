//
//  CountryOfStudyCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CountryOfStudyCell: UITableViewCell {
    @IBOutlet weak var countryName:UILabel!
    @IBOutlet weak var countryImage:UIImageView!
    
    @IBOutlet weak var imageBackView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:CountryModel){
        imageBackView.cornerRadius(imageBackView.frame.size.height/2)
        imageBackView.border(1, borderColor: .darkGray)
        countryName.text = model.name
        if model.image.isEmpty == false && model.image.isValidURL {
            if let url = URL(string:model.image ){
              countryImage.sd_setImage(with: url, placeholderImage: nil, options: [], progress: nil, completed: nil)
            }
        }
    }

}
