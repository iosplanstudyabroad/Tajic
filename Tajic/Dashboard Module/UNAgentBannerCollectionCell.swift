//
//  UNAgentBannerCollectionCell.swift
//  Unica New
//
//  Created by UNICA on 16/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNAgentBannerCollectionCell: UICollectionViewCell {
      @IBOutlet private weak var bannerImage:UIImageView!
    
    
    func configure(_ imagePath:String){
        if imagePath.isEmpty == false &&  imagePath.isValidURL,let url = URL(string: imagePath) {
            bannerImage.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
        }
    }
    
    
    
    
}
