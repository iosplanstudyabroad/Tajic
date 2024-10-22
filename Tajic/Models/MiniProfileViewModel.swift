//
//  MiniProfileViewModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class MiniProfileViewModel: NSObject {
    var currentVC:UIViewController? = nil
//previousModels:MiniProfileCommonModel
    func updateMiniProfile(_ model:MiniProfileCommonModel?,block:@escaping (_ bannerArray:[BannerModel])-> Swift.Void){
        updateProfileService(model, block: block)
    }
    
   func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}
extension MiniProfileViewModel{
    
  private  func prepareDictForUpdateProfile(_ previousModels:MiniProfileCommonModel?)-> [String:Any]?{
        guard let models = previousModels else {
            return nil
        }
        guard let stepOne = models.step1Model else {
            return nil
        }
//        guard let stepTwo = models.step2Model else {
//            return
//        }
        guard let stepThree = models.step3Model else {
            return nil
        }
        
        // let stepThree.qualifiedExams = ["aKey": "aValue", "anotherKey": "anotherValue"]
        let theJSONData = try?  JSONSerialization.data(
            withJSONObject: stepThree.qualifiedExams,
            options: .prettyPrinted
        )
        let theJSONText = String(data: theJSONData!,
                                 encoding: String.Encoding.utf8)
        
        //{
        print("JSON string = \n\(theJSONText!)")
        // }
        
        var educationArray = [[String:Any]]()
      
        let highschool = AppSession.share.miniProfileModel.highSchoolDetails
        let graduationDetails = AppSession.share.miniProfileModel.graduationDetails
        let postGraduationDetails = AppSession.share.miniProfileModel.postGraduationDetails
        let otherEducationDetails = AppSession.share.miniProfileModel.otherEducationDetails
       
        if highschool.schoolName.isEmpty == false || highschool.schoolName.isEmpty == true{
            let model = highschool
            let dict = ["degree_name":"high_school","institution_name":model.schoolName,"course_name":model.subjectName,"awarding_body":model.awardingBody,"year_of_passing":model.passingYear,"percentage":model.marks]
            educationArray.append(dict)
        }
        
        if graduationDetails.schoolName.isEmpty == false || graduationDetails.schoolName.isEmpty == true{
                   let model = graduationDetails
                   let dict = ["degree_name":"bachelors","institution_name":model.schoolName,"course_name":model.subjectName,"awarding_body":model.awardingBody,"year_of_passing":model.passingYear,"percentage":model.marks]
                   educationArray.append(dict)
               }
        
        if postGraduationDetails.schoolName.isEmpty == false || postGraduationDetails.schoolName.isEmpty == true{
                   let model = postGraduationDetails
                   let dict = ["degree_name":"masters","institution_name":model.schoolName,"course_name":model.subjectName,"awarding_body":model.awardingBody,"year_of_passing":model.passingYear,"percentage":model.marks]
                   educationArray.append(dict)
               }
        
        
        
        if otherEducationDetails.schoolName.isEmpty == false || otherEducationDetails.schoolName.isEmpty == true{
                         let model = otherEducationDetails
                         let dict = ["degree_name":"other","institution_name":model.schoolName,"course_name":model.subjectName,"awarding_body":model.awardingBody,"year_of_passing":model.passingYear,"percentage":model.marks]
                         educationArray.append(dict)
                     }
              
        let edujSONData = try?  JSONSerialization.data(
            withJSONObject:  educationArray,
            options: .prettyPrinted
        )
    _ = String(data: edujSONData!,
                                      encoding: String.Encoding.utf8)
        
        
        
        let jSONData = try?  JSONSerialization.data(
            withJSONObject:  stepThree.englishExamLevel,
            options: .prettyPrinted
        )
        let englishExamLevel = String(data: jSONData!,
                                      encoding: String.Encoding.utf8)
        
        //AppSession.share.miniProfileModel.firstStep.subgradePercentage
        var percentage = ""
        if AppSession.share.miniProfileModel.firstStep.subgradePercentage.isEmpty == false {
            percentage = AppSession.share.miniProfileModel.firstStep.subgradePercentage
        }
    var countryArray = [String]()
  if   AppSession.share.multiCountryList.isEmpty == false {
       AppSession.share.multiCountryList.forEach { (cModel) in
        if cModel.id.isEmpty == false {
         countryArray.append(cModel.id)
        }
    }
    }
    
    let countryData = try?  JSONSerialization.data(withJSONObject: countryArray,
                               options: .prettyPrinted
                     )
                     
                     var   countryString = String(data: countryData!,encoding: String.Encoding.utf8)
    if countryString == nil {
        countryString = ""
    }
   
    let interestedCategoryData = try?  JSONSerialization.data(withJSONObject: [AppSession.share.registerModel.fieldOfStudy],
              options: .prettyPrinted
    )
     var interestedCategoryString = String(data: interestedCategoryData!,encoding: String.Encoding.utf8)
        
    if interestedCategoryString == nil {
        interestedCategoryString = ""
    }
    
        let interestedCategoryData2 = try?  JSONSerialization.data(withJSONObject: [AppSession.share.registerModel.fieldOfStudySecondOption],
                  options: .prettyPrinted
        )
         var interestedCategoryString2  = String(data: interestedCategoryData2!,encoding: String.Encoding.utf8)
    
    if interestedCategoryString2 == nil {
        interestedCategoryString2 = ""
    }
    
    
    
    let  dataDict = ["app_agent_id":UserModel.getObject().agentId,"user_id":UserModel.getObject().id,"education_status":stepOne.isCompleted,"higher_education_name":stepOne.highEducationName,"highest_education_level_id":stepOne.highEducationId,"last_education_country_id":stepOne.coutryId,"grading_system_id":stepOne.gradeId,"sub_grading_system_id":stepOne.subgradeId,"institution_name":stepOne.instName,"sub_grading_system_percentage":percentage,
                        // step two
            "apply_education_level_id":AppSession.share.registerModel.levelOfStudy, // 1
            "apply_course_type_id":AppSession.share.registerModel.courseTypeId,    // mode of educations
            "interested_year":AppSession.share.registerModel.year,
            "interested_category_id":interestedCategoryString!, // stream of education
            "interested_category_id_option2":interestedCategoryString2!,
            
            // Setp three
            
            
            "valid_scores":stepThree.isValidScore,
            "qualified_exams":theJSONText!,
            "qualified_exam_scores":theJSONText!,
            "gre_exam_date":stepThree.greExamDate,
            "gre_verbal_score":stepThree.greVerbalScore,
            "gre_verbal":stepThree.greVerbal,
            "gre_quantitative_score":stepThree.greQuantitativeScore,
            "gre_quantitative":stepThree.greQuantitative,
            "gre_analytical_writing_score":stepThree.greAnalyticalWritingScore,
            "gre_analytical_writing":stepThree.greAnalyticalWriting,
            // Gmat
            "gmat_exam_date":stepThree.gMatExamDate,
            "gmat_verbal_score":stepThree.gMatVerbalScore,
            "gmat_verbal":stepThree.gMatVerbal,
            "gmat_quantitative_score":stepThree.gMatQuantitativeScore,
            "gmat_quantitative":stepThree.gMatQuantitative,
            "gmat_analytical_writing_score":stepThree.gMatAnalyticalWritingScore,
            "gmat_analytical_writing":stepThree.gMatAnalyticalWriting,
            "gmat_total_score":stepThree.gMatTotalScore,
            "gmat_total_percentage":stepThree.gMatTotalScorePer,
            // Sat
            "sat_raw_score":stepThree.sAtRawScore,
            "sat_math_score":stepThree.sAtMathScore,
            "sat_reading_score":stepThree.sAtReadingScore,
            "sat_writing_language_score":stepThree.sAtWritingLanguageScore,"sat_exam_date":stepThree.sAtExamDare,
            "sat_writing_score": stepThree.sAtWritingScore,
            
            /// step3Model.sAtWritingScore
            
          
            
            // dont have valid for
            "english_exam_level":englishExamLevel!,
            "budget_id":AppSession.share.registerModel.budget,
            "interested_country":countryString!
            ] as [String : Any]
        
        
       return dataDict
        
    }
    
}
extension MiniProfileViewModel {
    private func profileUpdate(_ model:MiniProfileCommonModel?,block:@escaping (_ bannerArray:[BannerModel])-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
       
        var  params = [String:Any]()
        if let data = prepareDictForUpdateProfile(model) {
            params = data
        }
        var tempBannerArray = [BannerModel]()
        ActivityView.hide()
        ActivityView.show()
        WebServiceManager.instance.studentUpdateMiniProfileWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let bannerArray = json["Payload"] as? [[String:Any]],bannerArray.isEmpty == false {
                    bannerArray.forEach({ (dict) in
                        let banner = BannerModel(with: dict)
                        tempBannerArray.append(banner)
                    })
                  block(tempBannerArray)
                }
                else{
                     block(tempBannerArray)
                    self.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                 block(tempBannerArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                 block(tempBannerArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }

}

extension MiniProfileViewModel {
   private func  updateProfileService(_ model:MiniProfileCommonModel?,block:@escaping (_ bannerArray:[BannerModel])-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
    
    var  params = [String:Any]()
    if let data = prepareDictForUpdateProfile(model) {
        params = data
    }
        
        ActivityView.show()
        WebServiceManager.instance.studentUpdateMiniProfileWithDetails(params:params) { [weak self](status, json) in
            switch status {
            case StatusCode.Success:
                if let code = json["Code"] as? Int, code == 200 {
                let model = UserModel.getObject()
                    model.profileCompleted = "Y"
                    model.saved()
                AppSession.share.miniProfileModel = MiniProfileModel()
                 ActivityView.hide()
                    
                    AppSession.share.alertWithPreferencesOption()
                return
            }
                if let data = json["Payload"] as? [String:Any]{
                    if let completed = data["profile_completed"] as? String{
                        let model = UserModel.getObject()
                        model.profileCompleted = completed
                        model.saved()
                        AppSession.share.miniProfileModel = MiniProfileModel()
                        AppSession.share.alertWithPreferencesOption()
                    }
                    print(data)
                }else{
                    self?.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
}

