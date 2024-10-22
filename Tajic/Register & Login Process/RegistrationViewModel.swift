//
//  RegistrationViewModel.swift
//  Unica
//
//  Created by Mohit Kumar  on 22/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
class RegistrationViewModel: NSObject {
    func registerStudent(_ image:UIImage?,_ model:RegistrationModel,block:@escaping(_ code:Int, _ dict:[String:Any])-> Swift.Void){
      registerNewStudent(image, model, block: block)
    }
    
    func getStudentProfile(block:@escaping(_ dict:[String:Any])-> Swift.Void){
      studentProfile(block: block)
    }
    
    func updateStudentProfile(_ image:UIImage?,_ model:RegistrationModel,block:@escaping(_ code:Int, _ dict:[String:Any])-> Swift.Void){
      updateStudent(image, model, block: block)
    }
    
    private  func showAlertMsg(msg: String){
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
    
    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
           // let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
          //  progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
         //   MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}

//***********************************************//
// MARK: Student Registration
//***********************************************//
extension RegistrationViewModel{
   private func registerNewStudent(_ image:UIImage?,_ model:RegistrationModel,block:@escaping(_ code:Int,_ dict:[String:Any])-> Swift.Void){
       guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg:"Internet not connected" )
                  return
              }
        var  imgData    = Data()
        if let userImage = image {
               imgData = userImage.jpegData(compressionQuality: 0.25)!
        }
        
    let url = ServiceConst.BaseUrl  + "update-profile.php"
    if (!JSONSerialization.isValidJSONObject(model.countryList)) {
           print("is not a valid json object")
           return
       }
let interestedCategoryData = try?  JSONSerialization.data(withJSONObject: [model.fieldOfStudy],
          options: .prettyPrinted
)
 let interestedCategoryString = String(data: interestedCategoryData!,encoding: String.Encoding.utf8)
    
    let interestedCategoryData2 = try?  JSONSerialization.data(withJSONObject: [model.fieldOfStudySecondOption],
              options: .prettyPrinted
    )
     let interestedCategoryString2  = String(data: interestedCategoryData2!,encoding: String.Encoding.utf8)
    
    
    let countryData = try?  JSONSerialization.data(withJSONObject: model.countryList,
              options: .prettyPrinted
    )
    
    let   countryString = String(data: countryData!,encoding: String.Encoding.utf8)
    
    let userId = AppSession.share.tempUserId
    let instance = AppSession.share
    let   parameters            = ["app_agent_id":instance.agentId,"firstname":model.firstName,"lastname":model.lastName,"mobileNumber":model.mobile,"email":model.email,"gender":model.gender,"password":model.password,"register_type":"S","socialId":model.socialid,"stype":model.stype,"deviceToken":model.deviceToken,"deviceType":"I","dob":model.dob,"residential_city":model.city,"country_id":model.countryId,"event_id":model.eventId,"apply_education_level_id":model.levelOfStudy,"interested_year":model.year,"interested_category_id":interestedCategoryString,"interested_category_id_option2":interestedCategoryString2,"budget_id":model.budget,"interested_country":countryString,"apply_course_type_id":model.courseTypeId,"user_id":userId]
    
        Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "profileImage",fileName: "profileImage.jpg", mimeType: "image/jpg")
            for (key, value) in parameters  {
                    if let keyValue = value  {
                     multipartFormData.append((keyValue).data(using: .utf8)!, withName: key)
                        print("Key:- \(key): value:\(keyValue)")
                    }
                    }
            },
        to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    self.dismissHUD(isAnimated: true)
                })
                upload.responseJSON { response in
                    
                    if let json = response.result.value as? [String:Any]{
                        print("URL:- \(url) :- /n")
                        print("Params:- \(parameters) :- /n")
                        print("Response:- \(json) :- \n")
                        block(200,json)
                    }
                     self.dismissHUD(isAnimated: true)
                }
            case .failure(let encodingError):
                print(encodingError)
                block(404,["":""])
                 self.dismissHUD(isAnimated: true)
            }
        }
    }
    }

extension RegistrationViewModel {
    private func updateStudent(_ image:UIImage?,_ model:RegistrationModel,block:@escaping(_ code:Int,_ dict:[String:Any])-> Swift.Void){
           guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg:"Internet not connected" )
                      return
                  }
            var  imgData    = Data()
            if let userImage = image {
                   imgData = userImage.jpegData(compressionQuality: 0.25)!
            }
            
        let url = ServiceConst.BaseUrl  + "update-profile.php"
        if (!JSONSerialization.isValidJSONObject(model.countryList)) {
               print("is not a valid json object")
               return
           }
    let interestedCategoryData = try?  JSONSerialization.data(withJSONObject: [model.fieldOfStudy],
              options: .prettyPrinted
    )
     let interestedCategoryString = String(data: interestedCategoryData!,encoding: String.Encoding.utf8)
        
        let interestedCategoryData2 = try?  JSONSerialization.data(withJSONObject: [model.fieldOfStudySecondOption],
                  options: .prettyPrinted
        )
         let interestedCategoryString2  = String(data: interestedCategoryData2!,encoding: String.Encoding.utf8)
        
        
        let countryData = try?  JSONSerialization.data(withJSONObject: model.countryList,
                  options: .prettyPrinted
        )
        
        let   countryString = String(data: countryData!,encoding: String.Encoding.utf8)
        
        let userId = UserModel.getObject().id
        
        let   parameters            = ["app_agent_id":UserModel.getObject().agentId,"firstname":model.firstName,"lastname":model.lastName,"mobileNumber":model.mobile,"email":model.email,"gender":model.gender,"password":model.password,"register_type":"S","socialId":model.socialid,"stype":model.stype,"deviceToken":model.deviceToken,"deviceType":"I","dob":model.dob,"residential_city":model.city,"country_id":model.countryId,"event_id":model.eventId,"apply_education_level_id":model.levelOfStudy,"interested_year":model.year,"interested_category_id":interestedCategoryString,"interested_category_id_option2":interestedCategoryString2,"budget_id":model.budget,"interested_country":countryString,"apply_course_type_id":model.courseTypeId,"user_id":userId]
        
            Alamofire.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(imgData, withName: "profileImage",fileName: "profileImage.jpg", mimeType: "image/jpg")
                for (key, value) in parameters  {
                        if let keyValue = value  {
                         multipartFormData.append((keyValue).data(using: .utf8)!, withName: key)
                            print("Key:- \(key): value:\(keyValue)")
                        }
                        }
                },
            to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                        self.dismissHUD(isAnimated: true)
                    })
                    upload.responseJSON { response in
                        
                        if let json = response.result.value as? [String:Any]{
                            print("URL:- \(url) :- /n")
                            print("Params:- \(parameters) :- /n")
                            print("Response:- \(json) :- \n")
                            block(200,json)
                        }
                         self.dismissHUD(isAnimated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    block(404,["":""])
                     self.dismissHUD(isAnimated: true)
                }
            }
        }
    
}

//***********************************************//
// MARK: Get User Profile
//***********************************************//

extension RegistrationViewModel{
   private func studentProfile(block:@escaping(_ dict:[String:Any])-> Swift.Void){
    guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg: AlertMsg.InternectDisconnectError)
        return
    }
    ActivityView.show()
    let id = UserModel.getObject().id
          
    let   params = ["app_agent_id":UserModel.getObject().agentId,"user_id":id]
     
    WebServiceManager.instance.studentGetProfileDetails(params: params) { (status, json) in
        switch status {
        case 200:if let code = json["Code"] as? Int {
            ActivityView.hide()
            switch code {
            case 200:
                if let data = json["Payload"] as? [String:Any] {
                 block(data)
                }else{
                    if let msg = json["Message"] as? String {
                        self.showAlertMsg(msg:msg )
                    }
                   
                }
            case 404:if let msg = json["Message"] as? String {
                self.showAlertMsg(msg:msg )
            }
            default:if let msg = json["Message"] as? String {
                self.showAlertMsg(msg:msg )
            }
            }
        }
        default: ActivityView.hide()
            if let msg = json["Message"] as? String {
            self.showAlertMsg(msg:msg )
        }
        }
    }
    
    
   
       }
    }


