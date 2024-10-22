//
//  AccreditationCollectionCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 19/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class AccreditationCollectionCell: UICollectionViewCell {
    @IBOutlet weak var card:GradientView!
    @IBOutlet weak var image:UIImageView!
    
    func configure(_ logo:String){
        if logo.isEmpty == false && logo.isValidURL {
            if let url = URL(string: logo){
                image.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
            }
            
        }
    }
}
