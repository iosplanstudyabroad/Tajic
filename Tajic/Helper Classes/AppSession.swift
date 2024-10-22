//
//  AppSession.swift
//  
//
//  Created by Mohit Kumar on 22/02/18.
//  Copyright © 2018 Unica Solutions Pvt Ltd. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import SwiftUI
class AppSession: NSObject {
    static let share: AppSession = {
        let instance = AppSession()
        return instance
    }()
    
    var firstName   = ""
    var lastName    = ""
    var email       = ""
    var countryId   = ""
    var mobileNo    = ""
    var dateOfBirth = ""
    var city        = ""
    var gender      = ""
    
    var isSearching       = false
    var isFormInstitution =  false
    var iHaveValidScore   = ""
    var registrationType = (id:0,type:"Apple")
    var registerModel = RegistrationModel()
    
        var yearList = [eventModel]()
       var budgetList = [eventModel]()
       var courseTypeList = [eventModel]()
    var degreeList = [DegreeModel]()
    var countryPopUpList = [CountryModel]()
    var multiCountryList = [CountryModel]()
    
    var allCourseList = [CountryModel]()
    var tempUserId = ""
    var menuArray = [MenuModel]()
    
     var miniProfileModel =  MiniProfileModel()
    
    
 var agentMobile  = ""
 var agentName    = ""
 var agentWhatsup = ""
    
    var greScoreModel    = GreScoreModel()
       var gMATScoreModel   = GMATScoreModel()
       var sATScoreModel  = SATScoreModel()
    
    var documentArray           = [DocumentModel]()
   
    var generalInfoArray = [GeneralInfoModel]()
    
    var filterCountryList = [CountryModel]()
    /*
    var instModel        = AvailableInstituteModel()
    */
    
    
    /*
    var loginType        = (id:0,type:"Student")
    var registrationType = (id:0,type:"Normal")
    var routesIdArray    = [String]()
    var menuArray        = [MenuModel]()
    var miniProfileModel = MiniProfileModel()
    
    var greScoreModel    = GreScoreModel()
    var gMATScoreModel   = GMATScoreModel()
    var sATScoreModel  = SATScoreModel()
    
    */
    var isFirstLoad      = false
    var isFirstLoadSelect = false
    var isfirsLoadSelectedExam = false
    
   /* var actionModel = DropDownModel()
    var categoryModel = DropDownModel()
    var templateModel = DropDownModel()
    var prospectModel = DropDownModel() */
    var remarks       = ""
    
    var categoryId = ""
    var educationId = ""
    
    var isActionTaken = false
    var isFormNotification  = false
    var isForHomeRedirection = false 
    var barXaxixArray      = ["Registered  Students", "Register on Event Date", "Request Sent", "Request Accept", "Meetings","Unique Scanned(by Admin)"]
    
    var tabDetails       = CourseTabModel()
   // var businessCardModel = BusinessCardListModel()
    var admissionYear:[String] = [String]()
    //***********************************************//
    // MARK: Qualification Models Implemented here
    //***********************************************//

    var jobUrl            = ""
    var jobPhoneNumber    = ""
    var jobWhatsAppNumber = ""
    
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: UDConst.UserAuthToken)
        }
        set {
            let s: UserDefaults = UserDefaults.standard
            if newValue != nil {
                s.set(newValue, forKey: UDConst.UserAuthToken)
            } else {
                s.removeObject(forKey: UDConst.UserAuthToken)
            }
            s.synchronize()
        }
    }
    var savedRouteCacheDate: String {
        if let date = UserDefaults.standard.object(forKey: UDConst.kUDRouteCacheDate) {
            return String(describing:date)
        }
        return "0000-00-00 00:00:00"
    }

    var savedStopCacheDate:String {
        if let date = UserDefaults.standard.object(forKey: UDConst.kUDRouteStopCacheDate) {
            return String(describing:date)
        }
        return "0000-00-00 00:00:00"
    }

    var savedRouteLatLongCacheDate: String {
        if let date = UserDefaults.standard.object(forKey: UDConst.kUDRouteLatLongCacheDate) {
            return String(describing:date)
        }
        return "0000-00-00 00:00:00"
    }
    
    
    var tabdetails = CourseTabModel()
    var agentId    = ""
    
    
    //===========================================================
    //MARK: - WebServcie Methods
    //===========================================================
    func logOutServiceCall(vc:UIViewController){}
    
    func logoutFB(){
        if  let current = AccessToken.current?.tokenString {
            let token = String(describing:current)
            
            AccessToken.current?.hasGranted(permission:"email")
            
            GraphRequest(graphPath: "me/permissions/email", parameters: [:], tokenString:token , version: "", httpMethod: .delete).start(completionHandler: { (connection, result, error) in
                
                
                if let dict = result as? [String:Any]{
                    print(dict)
                }
                
                LoginManager().logOut()
                
            })
        }
    }
    
}


extension AppSession {
    func logOutFromAllUsers(){
      /*  if let user =  UserDefaults.standard.object(forKey:UDConst.userLoginType) as? String, user == "Stu" {
          //  UserModel.clear()
        }else{
        }
        AdminUserModel.clear()
        UserModel.clear()
        InstitutionsUserModel.clear()
        GIDSignIn.sharedInstance()?.signOut()
        AppSession.share.logoutFB() */
        // self.logoutFB()
        //AppDelegate.shared.setRootViewController(vc: .Login)
    }
}


extension AppSession {
    func alertWithPreferencesOption(){
        
        let alert = UIAlertController(title: "ALERT!", message: "Thanks for telling us about your preferences we will now recommend you a few options based on your preferences", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home", style: .default, handler: { _ in
            AppDelegate.shared.setRootViewController(vc: .Home)
        }))
        
        alert.addAction(UIAlertAction(title: "Whatsapp", style: .default, handler: { _ in
            let what = AppSession.share.agentWhatsup
            if what.isEmpty == false {
                self.openWhatsapp(what,"")
            }else{
//            showAlertMsg(msg: "Whatsapp number is not present")
         }
            AppDelegate.shared.setRootViewController(vc: .Home)
        }))
        
        let scence = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if  let wind = scence {
            wind.rootViewController?.present(alert, animated: true, completion: nil)
       }
    }
    
}


extension AppSession {
    func openWhatsapp(_ phone:String,_ text:String){
        
        let urlWhats = "whatsapp://send?phone=\(phone)&abid=12354&text=\(text)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                   // self.showAlertMsg(msg: "Install Whatsapp")
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    
    
    
}
