//
//  appCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 18/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol appProtocol {
    func instituteNameTapped(_ model:ApplicationModel)
}
class appCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var appImage: UIImageView!
    
    @IBOutlet var appImageBackView: UIView!
    @IBOutlet var courseName: UILabel!
    @IBOutlet var universityName: UILabel!
    
    
    @IBOutlet var statusBackView: UIView!
    
    
    
    @IBOutlet var status: UILabel!
    var gesture = UITapGestureRecognizer()
    var selectedModel = ApplicationModel()
    var delegate:appProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    func configure(_ model:ApplicationModel){
        appImageBackView.cornerRadius(appImageBackView.frame.size.height/2)
        appImageBackView.border(1, borderColor: .gray)
        universityName.isUserInteractionEnabled = true
        selectedModel = model
        statusBackView.cornerRadius(statusBackView.frame.size.height/2)
        statusBackView.backgroundColor = UIColor().hexStringToUIColor(hex: "BC1773")
        gesture = UITapGestureRecognizer(target: self,
         action: #selector(self.universityClicked(_:)))
        universityName.addGestureRecognizer(gesture)
        card.cardView()
        universityName.textColor = UIColor().themeColor()
        self.courseName.text     = model.courseName
        self.universityName.text = model.university
        self.status.text         = model.status
        if model.countryImage.isEmpty == false &&  model.countryImage.isValidURL {
            if let url = URL(string: model.countryImage){
                appImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
            }
        }
    }
    
    @objc func universityClicked(_ sender:Any){
        self.selectedModel.isShowCourse = false
        delegate?.instituteNameTapped(selectedModel)
    }
}
