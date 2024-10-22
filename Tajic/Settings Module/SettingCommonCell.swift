//
//  SettingCommonCell.swift
//  CampusFrance
//
//  Created by UNICA on 20/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SettingCommonCell: UITableViewCell {
@IBOutlet weak var cardView: UIView!
@IBOutlet weak var menu: UILabel!
 @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var arrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardViewupdateLayerProperties()
    }
    
    var  menuArray = [[String:String]]()
// "About Us","Contact Us" ["title":"Change Password","image":"change_password.png"]
   
    
                        
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(index:Int){
        menuArray = [["title":"App Version","image":"app_version.png"]
                       ,["title":"Logout","image":"logout.png"]]
        
        let dict = menuArray[index] 
        menu.text = dict["title"]
        menuImage.image = UIImage(named: dict["image"]!)
        switch index {
        case 0:if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            labelVersion.text = version
        }
            arrowImage.isHidden = true
        default:arrowImage.isHidden = false
        }
    }
    func cardViewupdateLayerProperties() {
        cardView.cardView()
    }

}

