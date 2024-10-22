//
//  CourseDetailsUpparCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseDetailsUpparCell: UITableViewCell {
    
    @IBOutlet weak var intHeight: NSLayoutConstraint!
    @IBOutlet weak var intBack: UIStackView!
    @IBOutlet weak var instBackView: UIView!
    @IBOutlet weak var fevtBack: UIView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var institutionName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var addToFevtBtn:UIButton!
    var courseId = ""
    var model = CourseDetailsModel()
    
    var isProfileCourse = false
    var isFormFeature   = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(model:CourseDetailsModel){
        courseName.text = model.title
        institutionName.text = model.instituteName
        country.text = model.country
        if let url =  URL(string: model.countryFlag){
            logo.sd_setImage(with:url, placeholderImage: self.instBackView.instPlaceHolder, options: [], completed: nil)
        }
        instBackView.cardViewWithCircle()
        addToFevtBtn.cornerRadius(10)
        logo.cornerRadius(logo.frame.size.height/2)
        if model.isLike {
                   addToFevtBtn.setTitle("Remove  Favourite", for: .normal)
               }else{
                   addToFevtBtn.setTitle("Add  Favourite", for: .normal)
               }
     
        self.model = model
    }
    
    func formProfileCell(isProfileCourse:Bool) {
        self.isProfileCourse = isProfileCourse
    }

   
    
    @IBAction func addToFevtBtnTapped(_ sender:UIButton){
        if isFormFeature {
            addTofevtFeatureCourse(sModel: self.model)
            return
        }
        sendLikeDislike(sModel:self.model )
    }
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        sendLikeDislike(sModel:self.model )
       
    }
}


extension CourseDetailsUpparCell {
    func addTofevtFeatureCourse(sModel:CourseDetailsModel) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.id,] as [String : Any]
        
        if sModel.isLike {
            // "status":sModel.isLike
            params["status"] = "false"
        }else {
            params["status"] = "true"
        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeFeatureCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                              if let _ = json["Payload"] as? [String:Any]{
                  }
                  else{
                      ActivityView.showToast(msg:json["Message"] as! String )
                  }
                self.model.isLike =   !self.model.isLike
                  
                self.configure(model: self.model)
            case StatusCode.Fail:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    
    func sendLikeDislike(sModel:CourseDetailsModel) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.id,] as [String : Any]
        
        if sModel.isLike {
            // "status":sModel.isLike
            params["status"] = "false"
        }else {
            params["status"] = "true"
        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let _ = json["Payload"] as? [String:Any]{}
                else{
                    ActivityView.showToast(msg:json["Message"] as! String )
                }
              self.model.isLike =   !self.model.isLike
              self.configure(model: self.model)
            case StatusCode.Fail:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
}
