//
//  ShortListCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

protocol shortDelegate {
    func universityNameTapped(model:ShortListModel)
    func isLikeBtnTapped(model:ShortListModel,index:Int)
}
class ShortListCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var courseImage:UIImageView!
    @IBOutlet weak var courseName:UILabel!
    @IBOutlet weak var courseFee:UILabel!
    @IBOutlet weak var universityName:UIButton!
    @IBOutlet var fevtBtn: UIButton!
    var currentModel:ShortListModel? = nil
    var delegate:shortDelegate? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(_ model:ShortListModel){
        self.fevtBtn.cornerRadius(10)
        self.fevtBtn.setTitle("Remove  Favourite", for: .normal)
        self.currentModel = model
        self.courseName.text = model.courseName
        self.universityName.titleLabel?.numberOfLines = 0
        self.universityName.titleLabel?.lineBreakMode = .byWordWrapping
        self.universityName.titleLabel?.textAlignment = .left
        self.universityName.setTitle(model.universityName, for: .normal)
        self.courseFee.text = "Application Fee:- \(model.fee)"
        if model.courseImage.isEmpty == false && model.courseImage.isValidURL {
            if let url = URL(string: model.courseImage){
                courseImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
               
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.courseImage.cornerRadius(self.courseImage.frame.size.height/2)
            self.courseImage.border(1, borderColor: UIColor().themeColor())
        }
    }
  @IBAction func universityNameBtnTapped(_ sender: UIButton) {
         if let model = currentModel {
            model.isShowCourse = false
            model.isFromFeature = false
             delegate?.universityNameTapped(model: model)
         }
     }
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
       if let model = currentModel {
        delegate?.isLikeBtnTapped(model: model,index:sender.tag)
            }
    }
}
