//
//  GeneralInfoCell.swift
//  CampusFrance
//
//  Created by UNICA on 10/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GeneralInfoCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var menu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewupdateLayerProperties()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(model:GeneralInfoModel){
        menu.text = model.title
        if let url =  URL(string: model.icon) {
           iconImage.sd_setImage(with:url, placeholderImage: nil, options: [], context: nil)
        }
    }
    func cardViewupdateLayerProperties() {
        cardView.layer.shadowOffset  = CGSize(width: 0.5, height: 0.4)
        cardView.layer.shadowOpacity = 0.5  //
        cardView.layer.shadowRadius  = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius  = 0.0
    }
}
