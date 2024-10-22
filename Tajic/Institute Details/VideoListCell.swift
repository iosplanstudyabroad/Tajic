//
//  VideoListCell.swift
//  Unica New
//
//  Created by UNICA on 25/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class VideoListCell: UICollectionViewCell {
    @IBOutlet weak var thumb:UIImageView!
    override class func awakeFromNib() {
    }
    
    func configure(thumb:String){
        if let  videoId                    = thumb.split(separator: "=").last {
           let thumUrl                     = getThumbUrl(videoId: String(videoId))
            if thumUrl.isValidURL, let url = URL(string: thumUrl) {
                self.thumb.sd_setImage(with:url , completed: nil)
                self.thumb.border(1, borderColor: UIColor().themeColor())
            }
        }
    }
    func getThumbUrl(videoId:String)-> String {
     let thumbImage =  "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg"
      return thumbImage
    }
}
