//
//  CourseCell.swift
//  Unica New
//
//  Created by UNICA on 25/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var leftView:UIView!
    @IBOutlet weak var imageBackView:UIView!
    @IBOutlet weak var courseImage:UIImageView!
    @IBOutlet weak var courseName:UILabel!
    @IBOutlet weak var courseFee:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        initialSetup()
        
    }
    
    func initialSetup(){
        card.cardView()
        imageBackView.cardViewWithCircle()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
        self.leftView.roundCorners([.bottomLeft,.topLeft], radius: 10)
        }
    }
}
//***********************************************//
// MARK: Configure Method defined here
//***********************************************//

extension CourseCell {
    func configure(model:CourseModel){
        self.courseName.text = model.courseName
        self.courseFee.text = "Application Fee: " + model.applicationFee
    }
}
