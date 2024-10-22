//
//  MarketingDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class MarketingDetailsCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var logo: UIImageView!
     @IBOutlet var logoSupportView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:MarketingModel){
        self.layoutIfNeeded()
        self.title.text = model.title
        self.card.cardView()
        self.logo.backgroundColor = UIColor().themeColor()
         self.logoSupportView.backgroundColor = UIColor().themeColor()
         self.logo.image = self.logo.image?.withRenderingMode(.alwaysTemplate)
         
        self.logo.tintColor = .white
     //   self.logo.cornerRadius(self.logo.frame.size.height/2)
       self.logoSupportView.cornerRadius(self.logoSupportView.frame.size.height/2)
        self.logoSupportView.border(1, borderColor: .black)
        
        
//        if model.prospectus.isEmpty == false && model.prospectus.isValidURL, let url = URL(string: model.prospectus) {
//            self.logo.sd_setImage(with:url , completed: nil)
//        }
        self.layoutIfNeeded()
    }
}
