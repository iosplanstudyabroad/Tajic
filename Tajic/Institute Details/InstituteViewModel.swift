//
//  InstituteViewModel.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteViewModel: NSObject {
    func instituteDetails(_ instituteId:String,block:@escaping(_ model:InstituteDetailsModel)-> Swift.Void){
        getInstituteDetails(instituteId, block:block)
    }
    
    func instituteCourses(_ index:Int,_ sortType:String,_ instituteId:String,block:@escaping(_ courseList:[CourseModel])-> Swift.Void){
        getInstituteCourses(index,sortType,instituteId, block: block)
    }
    func featrueInstituteDetails(_ instituteId:String,block:@escaping(_ model:InstituteDetailsModel)-> Swift.Void){
          getFeatureInstituteDetails(instituteId, block:block)
      }

    
    func featureinstituteCourses(_ index:Int,_ sortType:String,_ instituteId:String,block:@escaping(_ courseList:[CourseModel])-> Swift.Void){
           getFeatureInstituteCourses(index,sortType,instituteId, block: block)
       }
    
    
    private  func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}

//***********************************************//
// MARK: Institute Details Service
//***********************************************//
extension InstituteViewModel{
    
    
    private func getFeatureInstituteDetails(_ instituteId:String,block:@escaping(_ array:InstituteDetailsModel)-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
    let model            = UserModel.getObject()
        let params           = ["userid": model.id,"institute_id":instituteId,"app_agent_id":model.agentId]
        let instituteDetails = InstituteDetailsModel()
        ActivityView.show()
        WebServiceManager.instance.getFeaturInstuteDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let instDetails = json["Payload"] as? [String:Any] {
                     let model =  InstituteDetailsModel(with: instDetails)
                   block(model)
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                   block(instituteDetails)
                }
                ActivityView.hide()
            case StatusCode.Fail:
               block(instituteDetails)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
             block(instituteDetails)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
   private func getInstituteDetails(_ instituteId:String,block:@escaping(_ array:InstituteDetailsModel)-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
    let model            = UserModel.getObject()
        let params           = ["app_agent_id":model.agentId,"userid": model.id,"institute_id":instituteId]
        let instituteDetails = InstituteDetailsModel()
        ActivityView.show()
        WebServiceManager.instance.getInstuteDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let instDetails = json["Payload"] as? [String:Any] {
                     let model =  InstituteDetailsModel(with: instDetails)
                   block(model)
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                   block(instituteDetails)
                }
                ActivityView.hide()
            case StatusCode.Fail:
               block(instituteDetails)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
             block(instituteDetails)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    
    private func getInstituteCourses(_ index:Int,_ sortType:String,_ instituteId:String,block:@escaping(_ courseList:[CourseModel])-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model            = UserModel.getObject()
        let params           = ["app_agent_id":model.agentId,"userid": model.id,"institute_id":instituteId,"sort_by":sortType]
        var courseArray  = [CourseModel]()
        ActivityView.show()
        WebServiceManager.instance.getinstituteCourseList(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let courseArr  = json["Payload"] as? [[String:Any]] {
                    courseArr.forEach { (dict) in
                        let model = CourseModel(With: dict)
                       courseArray.append(model)
                    }
                   block(courseArray)
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                   block(courseArray)
                }
                ActivityView.hide()
            case StatusCode.Fail:
               block(courseArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
             block(courseArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    
    
    
    
    private func getFeatureInstituteCourses(_ index:Int,_ sortType:String,_ instituteId:String,block:@escaping(_ courseList:[CourseModel])-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model            = UserModel.getObject()
        let params           = ["app_agent_id":model.agentId,"userid": model.id,"institute_id":instituteId,"sort_by":sortType]
        var courseArray  = [CourseModel]()
        ActivityView.show()
        WebServiceManager.instance.getFeatureinstituteCourseList(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let courseArr  = json["Payload"] as? [[String:Any]] {
                    courseArr.forEach { (dict) in
                        let model = CourseModel(With: dict)
                       courseArray.append(model)
                    }
                   block(courseArray)
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                   block(courseArray)
                }
                ActivityView.hide()
            case StatusCode.Fail:
               block(courseArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
             block(courseArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    
    
}
/// getFeatureinstituteCourseList
