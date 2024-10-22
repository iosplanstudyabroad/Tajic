//
//  SearchCourseCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SearchCourseCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var InsImage: UIImageView!
    @IBOutlet weak var instituteName: UILabel!
    @IBOutlet weak var fevtBtn: UIButton!
     @IBOutlet weak var didSelectBtn: UIButton!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var universityName: UIButton!
    
    @IBOutlet var univeristyImageBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
       // card.cardView()
    }

    func configure(model:SearchCoursesModel,isMatch:Bool){
       // fevtBtn.cornerRadius(fevtBtn.frame.size.height/2)
        if model.isLike {
            
            fevtBtn.setTitle("Remove  Favourite", for: .normal)
          //fevtBtn.setImage(favoriteImg, for: .normal)
        }else{
            fevtBtn.setTitle("Add  Favourite", for: .normal)
            
          // fevtBtn.setImage(unFavoriteImg, for: .normal)
        }
        menuTitle.lineBreakMode = .byWordWrapping
        menuTitle.text = model.courseTitle
        
        universityName.setTitle(model.instituteName, for: .normal)
        universityName.titleLabel?.lineBreakMode = .byWordWrapping
        //universityName.setTitleColor(UIColor().themeColor(), for: .normal)
        fee.text = "Application Fee :- " + model.appFee //model.applicationFee
         fee.lineBreakMode = .byWordWrapping
        if isMatch {
          fee.text = "Application Fee :- " + model.appFee
        }
       
        InsImage.sd_setImage(with: URL(string: model.logo), placeholderImage: self.card.instPlaceHolder, options: [], context: nil)
        
        self.InsImage.cornerRadius(self.InsImage.frame.size.height/2)
        self.InsImage.border(1, borderColor: UIColor().themeColor())
 self.fevtBtn.cornerRadius(10)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                   self.InsImage.cornerRadius(self.InsImage.frame.size.height/2)
                   self.InsImage.border(1, borderColor: UIColor().themeColor())
            self.fevtBtn.cornerRadius(10)//roundCorners([.bottomLeft,.bottomRight], radius: 10)
               }
       
    }
    
    @IBAction func fevtBtnTapped(_ sender:UIButton){}
  
    
    func attributedString(title:String)-> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes:[NSAttributedString.Key.link: URL(string: "http://www.google.com/\(self.fevtBtn.tag)")!])
        return attributedString
    }
}



/*
import UIKit

class SearchCourseCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var InsImage: UIImageView!
    @IBOutlet weak var instituteName: UILabel!
    @IBOutlet weak var fevtBtn: UIButton!
     @IBOutlet weak var didSelectBtn: UIButton!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var universityName: UIButton!
    @IBOutlet weak var universityImageBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
       // card.cardView()
    }

    func configure(model:SearchCoursesModel,isMatch:Bool){
       // fevtBtn.cornerRadius(fevtBtn.frame.size.height/2)
        if model.isLike {
            fevtBtn.setTitle("Remove  Favourite", for: .normal)
          //fevtBtn.setImage(favoriteImg, for: .normal)
        }else{
            fevtBtn.setTitle("Add  Favourite", for: .normal)
          // fevtBtn.setImage(unFavoriteImg, for: .normal)
        }
        menuTitle.lineBreakMode = .byWordWrapping
        menuTitle.text = model.courseTitle
        
        universityName.setTitle(model.instituteName, for: .normal)
        universityName.titleLabel?.lineBreakMode = .byWordWrapping
        universityName.setTitleColor(UIColor().themeColor(), for: .normal)
        fee.text = "Application Fee :- " + model.applicationFee
         fee.lineBreakMode = .byWordWrapping
        if isMatch {
          fee.text = "Application Fee :- " + model.appFee
        }
       
        InsImage.sd_setImage(with: URL(string: model.logo), placeholderImage: self.card.instPlaceHolder, options: [], context: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.InsImage.cornerRadius(self.InsImage.frame.size.height/2)
            self.InsImage.border(1, borderColor: UIColor().themeColor())
            self.fevtBtn.roundCorners([.bottomLeft,.bottomRight], radius: 10)
               }
    }
    
    @IBAction func fevtBtnTapped(_ sender:UIButton){}
  
    func attributedString(title:String)-> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes:[NSAttributedString.Key.link: URL(string: "http://www.google.com/\(self.fevtBtn.tag)")!])
        return attributedString
    }
}
*/
