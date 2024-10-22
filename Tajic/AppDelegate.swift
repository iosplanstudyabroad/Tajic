//
//  AppDelegate.swift
//  unitree
//
//  Created by Mohit Kumar  on 07/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import  GoogleSignIn
import GoogleMaps
import IQKeyboardManager
import FBSDKLoginKit
import Firebase
import FirebaseMessaging
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared: AppDelegate {
          return UIApplication.shared.delegate! as! AppDelegate
      }
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // AppSession.share.agentId = "1"
        appConfiguration()
        configureLogins(application,launchOptions)
        decideToMoveViewController()
    PushNotificationHandler.instance.configurePushNotfication(self)
        
        
            FirebaseConfiguration.shared.setLoggerLevel(.min)
            FirebaseApp.configure()
            Analytics.setAnalyticsCollectionEnabled(false)
            //Analytics.logEvent("", parameters: )
            

            Messaging.messaging().delegate = self
        
        
        
        return true
    }
    
    
    func base()-> String{
        var baseUrl = ""
        var   url = ServiceConst.BaseUrl.split(separator: "/")
         url.removeLast()
        
      var seprated =   url.joined(separator: "/") + "/tajic_travels/configurations.php"
    
     seprated =    seprated.replacingOccurrences(of:"https:/" , with:"https://" )
        baseUrl = seprated
       
       return baseUrl
    }
    //
    
    func configureLogins(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?){
        IQKeyboardManager.shared().isEnabled = true
       configureFaceBookLogin(app, options)
        GMSServices.provideAPIKey("AIzaSyCz9KdavgnJXqMjL1Hy10q-zNjOkzlrWQU")
    }
}

extension AppDelegate {
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            if  ApplicationDelegate.shared.application(app, open: url, options: options){
                return true
            }
            let urlRes =  GIDSignIn.sharedInstance.handle(url)
            return urlRes
        }
    
        func configureFaceBookLogin(_ application:UIApplication,_ launchOptions:[UIApplication.LaunchOptionsKey: Any]?){
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
}
extension AppDelegate {
   func decideToMoveViewController(){
    if UserModel.getObject().id.isEmpty == false {
           setRootViewController(vc: .Home)
       }
       else{
           setRootViewController(vc: .Login)
       }
   }
   
   func setRootViewController(vc:RootViewController){
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       switch vc {
       case .Login:
           let login = storyBoard.instantiateViewController(withIdentifier:"Nav_Login")
           self.window?.rootViewController = login
       case .Home:
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       let lfMenu                        = storyBoard.instantiateViewController(withIdentifier: "LeftMenuInitialStudent")
       self.window?.rootViewController = lfMenu
   }
    }
}

extension AppDelegate {
    func appConfiguration(){
        let model = StudentDashBoardViewModel()
        model.getAppConfigurationDetails { (dict) in
      if UserModel.getObject().id.isEmpty {
                var agentId = ""
      if let id = dict["app_agent_id"] as? String {
             agentId = id
      }
             if let id = dict["app_agent_id"] as? Int {
                agentId = String(id)
                }
                AppSession.share.agentId = agentId
                
                if let courseDict = dict["course_tabs"] as? [String:Any]{
                    let tabModel = CourseTabModel(courseDict)
                    AppSession.share.tabdetails = tabModel
            }
                let uModel = UserModel.getObject()
                          if let id = dict["app_agent_id"] as? String {
                            uModel.agentId = id
                          }
                         if let id = dict["app_agent_id"] as? Int {
                          uModel.agentId = String(id)
                      }
                uModel.saved()
                
        }else{
                var agentId = ""
                  if let id = dict["app_agent_id"] as? String {
                   agentId = id
                        }
                if let id = dict["app_agent_id"] as? Int {
                agentId = String(id)
                }
                AppSession.share.agentId = agentId
                
                if let courseDict = dict["course_tabs"] as? [String:Any]{
                    let tabModel = CourseTabModel(courseDict)
                    AppSession.share.tabdetails = tabModel
            }
                self.processConfigurtion(dict)
        }
    }
    }
    
    func processConfigurtion(_ dict:[String:Any]){
            let uModel = UserModel.getObject()
            if let id = dict["app_agent_id"] as? String {
              uModel.agentId = id
            }
           if let id = dict["app_agent_id"] as? Int {
            uModel.agentId = String(id)
        }
        if let courseDict = dict["course_tabs"] as? [String:Any]{
            let tabModel = CourseTabModel(courseDict)
          uModel.tabDetails = tabModel
        }
        uModel.profileCompleted = "Y"
        uModel.saved()
    }
}


extension AppDelegate:MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        if let deviceTokenString = fcmToken {
            UserDefaults.standard.setValue(String(describing: deviceTokenString), forKey: PushNotificationHandler.pushNotificationKey)
             UserDefaults.standard.synchronize()
        }
          let dataDict: [String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
          )


    }
    
}
