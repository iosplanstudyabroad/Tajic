//
//  SettingsNotificationCell.swift
//  CampusFrance
//
//  Created by UNICA on 20/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SettingsNotificationCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewupdateLayerProperties()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func cardViewupdateLayerProperties() {
        cardView.layer.shadowOffset  = CGSize(width: 0.5, height: 0.4)
        cardView.layer.shadowOpacity = 0.5  //
        cardView.layer.shadowRadius  = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius  = 0.0
    }
    
}
