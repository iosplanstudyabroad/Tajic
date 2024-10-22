//
//  NewSearchCourseViewModel.swift
//  SVC
//
//  Created by Mohit Kumar  on 27/11/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

/*
 params["filter_country_id"] = self.filterCountryId
 */

class NewSearchCourseViewModel: NSObject {
    func getFeatureCourseList(index:Int,keyWord:String?,filter:String?,block:@escaping(_ statusCode:Int,_ index:Int,_ featureCourseArray:[SearchCoursesModel])-> Swift.Void){
        featureCourseList(index, keyWord, filter: filter, block: block)
    }
    
    func getPefectMatchCourseList(index:Int,keyWord:String?,filter:String?,block:@escaping(_ statusCode:Int
        ,_ index:Int,_ perfectCourseArray:[SearchCoursesModel])-> Swift.Void){
        perfectMatchCourses(index, keyWord, filter: filter, block: block)
    }
    
    private  func showAlertMsg(msg: String){
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}

//***********************************************//
// MARK: Institute Details Service
//***********************************************//
extension NewSearchCourseViewModel{
    
  private  func featureCourseList(_ index:Int,_ keyWord:String?,filter:String?,block:@escaping(_ statusCode:Int,_ index:Int,_ featureCourse:[SearchCoursesModel])-> Swift.Void) {
            guard StaticHelper.isInternetConnected else {
                showAlertMsg(msg: AlertMsg.InternectDisconnectError)
                return
            }
            let model = UserModel.getObject()
            
            var  params = ["app_agent_id":model.agentId,"user_id": model.id,"user_type":model.userType,"pageNumber":index,"match_course_hide":"Y"] as [String : Any]
        
                    if let search = keyWord {
                      params["keyword"] = search
                      }
            
                    if let country = filter {
                        params["filter_country_id"] = country
                    }
                   
            var courseList = [SearchCoursesModel]()
    
            WebServiceManager.instance.getSearchCourseFeatureListWithDetails(params: params) { (status, json) in
                switch status {
                case StatusCode.Success:
                    if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]], courseArr.isEmpty == false {
                        courseArr.forEach({ (dict) in
                            let model = SearchCoursesModel(with: dict)
                            courseList.append(model)
                        })
                        block(200,index,courseList)
                    }
                    else{
                        if index == 1 {
                            if let msg =  json["Message"] as? String {
                                self.showAlertMsg(msg: msg)
                            }
                        }
                        
                        if let code = json["Code"] as? Int {
                           block(code,index,courseList)
                            return
                        }
                    }
                    ActivityView.hide()
                case StatusCode.Fail:
                    ActivityView.hide()
                    self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
                case StatusCode.Unauthorized:
                    ActivityView.hide()
                    self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
                default:break
                }
            }
        }
}

extension NewSearchCourseViewModel {
    func perfectMatchCourses(_ index:Int,_ keyWord:String?,filter:String?,block:@escaping(_ statusCode:Int,_ index:Int,_ perfectMatchCourseArray:[SearchCoursesModel])-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"pageNumber":index,"match_course_hide": "N"] as [String : Any]
        
        if let search = keyWord {
           params["keyword"] =  search
        }
        
        if let country = filter {
          params["filter_country_id"] = country
           }
        
        var courseList = [SearchCoursesModel]()
        
        WebServiceManager.instance.getSearchMatchedCoursesStatusWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                 ActivityView.hide()
                 if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]],courseArr.isEmpty == false {
                    
                    courseArr.forEach({ (dict) in
                        let model = SearchCoursesModel(with: dict)
                        courseList.append(model)
                    })
                    block(200,index,courseList)
                }
                else{
                    if index == 1 {
                        if let msg = json["Message"] as? String {
                          self.showAlertMsg(msg: msg)
                        }
                    }
                    
             if let code = json["Code"] as? Int {
              block(code,index,courseList)
                return
                }
             
                }
                ActivityView.hide()
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

extension NewSearchCourseViewModel{
    func featureAddRemoveFromFevt(_ sModel:SearchCoursesModel) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.courseId,] as [String : Any]
        
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
                if let data = json["Payload"] as? [String:Any]{
                    print(data)
                }
                else{
                    ActivityView.showToast(msg:json["Message"] as! String )
                }
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


extension NewSearchCourseViewModel {
    func perfectMatchAddRemoveFevt(_ sModel:SearchCoursesModel) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.courseId,] as [String : Any]
        
        if sModel.isLike {
            
            params["status"] = "false"
        }else {
            params["status"] = "true"
        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let data = json["Payload"] as? [String:Any]{
                    print(data)
                }
                else{
                    if let msg = json["Message"] as? String {
                       ActivityView.showToast(msg:msg)
                    }
                }
                
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
