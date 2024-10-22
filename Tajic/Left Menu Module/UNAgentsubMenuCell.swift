
//
//  UNAgentsubMenuCell.swift
//  Unica New
//
//  Created by UNICA on 27/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNAgentsubMenuCell: UITableViewCell {
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var name:UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ model:SubMenuModel){
        name.text = model.leftMenuTitle
        if model.leftMenuIconUrl.isEmpty == false &&  model.leftMenuIconUrl.isValidURL == true {
            if let url = URL(string: model.leftMenuIconUrl) {
                icon.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
            }
            if let image = icon.image {
             let coloredImg =    image.withColor(UIColor.white)
               icon.image = coloredImg
            }
        }
    }
}
