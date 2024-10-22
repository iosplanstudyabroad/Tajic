//
//  InstituteNameCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class InstituteNameDetailsCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var logo:UIImageView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var address:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        self.name.text = model.name
        self.address.text = "\(model.city), \(model.state), \(model.location)"
        if model.image.isEmpty == false && model.image.isValidURL, let url = URL(string: model.image) {
                self.logo.sd_setImage(with:url , completed: nil)
                self.logo.border(1, borderColor: UIColor().themeColor())
            self.logo.cornerRadius(self.logo.frame.size.height/2)
            }
        }
    }
