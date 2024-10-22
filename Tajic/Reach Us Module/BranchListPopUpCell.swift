//
//  BranchListPopUpCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class BranchListPopUpCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var branchName:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ title:String,isSelected:Bool){
        self.branchName.text = title
        
        card.backgroundColor = .lightGray
        if isSelected {
            branchName.textColor = UIColor.white
            
        }else{
             branchName.textColor = UIColor.black
        }
    }
    
}
