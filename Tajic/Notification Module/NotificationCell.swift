//
//  NotificationCell.swift
//  CampusFrance
//
//  Created by UNICA on 03/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var descLbl:UILabel!
   
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        card.cardView()
    }

   
    func configureCell(model:NotificationModel){
        titleLbl.text = "\(model.id)" + model.title 
        descLbl.text = model.message
        
        
       
        if model.isUnread == true {
            self.card.backgroundColor =
             UIColor().hexStringToUIColor(hex: "#e0dcdc")
        }else{
             self.card.backgroundColor = UIColor.white
        }

        self.layoutIfNeeded()
    }
}
