//
//  CourseLowerIntakeCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseLowerIntakeCell: UITableViewCell {

    @IBOutlet weak var intakeLabl: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(model:CourseDetailsModel){
     // year
        var yAxis = iconImg.frame.origin.y+iconImg.frame.size.height+2
        var yAxisImg = iconImg.frame.origin.y+iconImg.frame.size.height+2
        if let ind = model.courseIntakeArray.first{
           intakeLabl.text = ind.courseMonthDeadline
        }
        
        for (index, value ) in model.courseIntakeArray.enumerated() {
            let width = UIScreen.main.bounds.width - 30
            let label = UILabel(frame: CGRect(x: 10, y: Int(yAxis), width: Int(width), height: 20))
          
           label.textColor = UIColor.darkGray
            let imageView = UIImageView()
            label.font = UIFont.systemFont(ofSize: 15.0)
            imageView.image = UIImage(named: "year.png")
            if index == 0 {
            
            }else if index == 1 {
                let xAxis = Int(iconImg.frame.origin.x)
                imageView.frame = CGRect(x:xAxis , y: 80, width:20, height: 20)
                label.frame =  CGRect(x: Int( imageView.frame.origin.x+imageView.frame.size.width)+10, y: 80, width: Int(width), height: 20)
                  label.text = value.courseMonthDeadline
            }else{
                let xAxis = Int(iconImg.frame.origin.x)
                imageView.frame = CGRect(x:xAxis , y: Int(yAxisImg), width:20, height: 20)
                label.frame =  CGRect(x: Int( imageView.frame.origin.x+imageView.frame.size.width)+10, y: Int(yAxis), width: Int(width), height: 20)
                  label.text = value.courseMonthDeadline
            }
            
            self.contentView.addSubview(imageView)
            self.contentView.addSubview(label)
            yAxis =  label.frame.origin.y + label.frame.size.height + 5
            yAxisImg = imageView.frame.origin.y+imageView.frame.size.height+2
        }
//        array.forEach { (model) in
//            let width = UIScreen.main.bounds.width - 30
//            let label = UILabel(frame: CGRect(x: 10, y: yAxis, width: Int(width), height: 20))
//            label.text = "model"
//        }
//
       // intakesText.text = str
    }

}
