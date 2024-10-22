//
//  EnglishSubCell.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class EnglishSubCell: UITableViewCell {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var elts: UILabel!
    @IBOutlet weak var toefl: UILabel!
    
    @IBOutlet var back: [UIView]!
    let colorArray = [UIColor().hexStringToUIColor(hex: "#AED6F1"),
                      UIColor().hexStringToUIColor(hex: "#AED6F1"),
                      UIColor().hexStringToUIColor(hex: "#A9DFBF"),
                      UIColor().hexStringToUIColor(hex: "#A9DFBF"),
                      UIColor().hexStringToUIColor(hex: "#F9E79F"),
                      UIColor().hexStringToUIColor(hex: "#F9E79F"),
                      
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"),
                      UIColor().hexStringToUIColor(hex: "#ffffff"), ]
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = 0
        self.layer.borderWidth   = 0
        self.layer.borderColor   = UIColor().themeColor().cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        if selected {
//            self.layer.borderWidth   = 1
//        }else{
//             self.layer.borderWidth   = 0
//        }
       
    }
    
    func setupColor(index:Int){
        back.forEach { (selectedview) in
            selectedview.backgroundColor = colorArray[index]
        }
    }
    func clearBackGround(){
        back.forEach { (selectedview) in
            selectedview.backgroundColor = UIColor.white
        }
    }
}
