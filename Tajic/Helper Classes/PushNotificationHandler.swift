//
//  PushNotificationHandler.swift
//  nixt
//
//  Created by Dex_Mac2 on 9/29/17.
//  Copyright © 2017 Dex_Mac2. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseMessaging
class PushNotificationHandler: NSObject {
    static let instance            = PushNotificationHandler()
    static let pushNotificationKey = "PushNotification"
    
    static var deviceToken:String{
        if let deviceID = UserDefaults.standard.object(forKey: pushNotificationKey) {
            return (deviceID as! String)
        }
        return "#iOS"
    }
    var apnsJson:[String:Any]?
    
    //===========================================================
    //MARK: - Initialization Method
    //===========================================================
    private override init() {
        super.init()
    }
    func desideToMoveViewController(aps:UNNotificationResponse) {
     //   let actionIdentifier = aps.actionIdentifier
      
       if let jsons                           = apnsJson, let payload =  jsons["payload"] as? [String:Any], let data = payload["data"] as? [String:Any] {
        var payLodDict                        = [String:Any]()
        var dataDict                          = [String:Any]()
        
        if let id                             = data["id"] as? Int {
           dataDict["id"]                     = id
        }
        if let timestamp                      = data["timestamp"] as? String {
            dataDict["timestamp"]             = timestamp
        }
        if let notification_category          = data["notification_category"] as? Int {
            dataDict["notification_category"] = notification_category
        }
        
        if let dict = data["payload"] as? [String:Any] {
            payLodDict = dict
        }
        
       
        
        let model = NotificationModel(with: payLodDict)
        
     /*   switch actionIdentifier {
        case "yesAction":print("Yes Action Tapped")
        redirectToNotificationListWithAction(data:data,action:"Y")
            return
        case "noAction":print("No Action Tapped")
        redirectToNotificationListWithAction(data:data,action:"N")
            return
        default:break
        }*/
        
        
        switch model.notificationCategory {
        case 1:showParticipantDetails(data:data)
        case 2:openUrl(url: model.urlToRedirect)
        case 3:moveToMenusAccordingToData(data:data)
        case 4:redirectToNotificationList(data:data)
        case 5:moveToMenusAccordingToData(data:data)
        default:break
        }

        }
    }
    
    func redirectToNotificationListWithAction(data:[String:Any],action:String){
       // if let payld = data["payload"] as? [String:Any] {}
        
    }
            /*
            let model = NotificationModel(with: payld)
            /*
             ,
             let senderId = payld["sender_id"] as? String,let senderType = payld["sender_type"] as? String, let receiverType = payld["receiver_type"] as? String
             */
            if  let receiverType = payld["receiver_type"] as? String {
                if receiverType == "S" {
                    if  UserModel.getObject().id.isEmpty {
                        AppDelegate.shared.setRootViewController(vc: .Login)
                        return
                    }
                }
                    
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if   let vc = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC {
                    vc.isFromPush = true
                    
                    vc.actionModel      = model
                    vc.isActionSeleted  = true
                    vc.selectedAction   = action
                    
                    
                    let nav1                      = UINavigationController()
                    nav1.viewControllers          = [vc]
                  //  AppDelegate.shared.window!.rootViewController = nav1
                   // AppDelegate.shared.window!.makeKeyAndVisible()
                }
            }
            
            
//            var notificationId = ""
//            var userId = ""
//            var notificationUserType = ""
            
            
        }
        
        */
        
    
    func redirectToNotificationList(data:[String:Any]){
             if  UserModel.getObject().id.isEmpty {
                 AppDelegate.shared.setRootViewController(vc: .Login)
                 return
             }
         //}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if   let vc = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC {
             vc.isFromPush = true
             let nav1                      = UINavigationController()
             nav1.viewControllers          = [vc]
             AppDelegate.shared.window!.rootViewController = nav1
             AppDelegate.shared.window!.makeKeyAndVisible()
         }
    }
    
    
    func showParticipantDetails(data:[String:Any]){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let payld = data["payload"] as? [String:Any]
            {
                print(payld)
            if  UserModel.getObject().id.isEmpty {
                AppDelegate.shared.setRootViewController(vc: .Login)
                return
            }
                AppDelegate.shared.setRootViewController(vc: .Home)
        }
    }
    
    func openUrl(url:String){
        guard let reUrl = URL(string:url ) else {
            return
        }
        UIApplication.shared.open(reUrl, options: [:], completionHandler: nil)
       
    }
    
    //===========================================================
    //MARK: - Notification Handler
    //===========================================================
        
    
    func configurePushNotfication(_ delegate:AppDelegate) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().delegate = delegate
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted, error) in
                if granted {
                    DispatchQueue.main.async {
                        let shared = UIApplication.shared
                shared.registerForRemoteNotifications()
                    }
                }else{
                    print("User Notification permission denied:\(String(describing: error?.localizedDescription))")
                }
            })
        }
    }

        
   func gettingPushNotificationToken(_ token:Data){
        let deviceTokenString = token.reduce("", {$0 + String(format: "%02X", $1)})
       // 
        //print("APNs device token: \(deviceTokenString)")
    }
    func didReceivePushNotificationData(_ response:Any?){
        guard let data = response else {
            return
        }
            if let aps = data as? UNNotificationResponse {
                let userInfo = aps.notification.request.content.userInfo
                apnsJson = userInfo  as? [String:Any]
            desideToMoveViewController(aps: aps)
            }
    }
    }
    

//***********************************************//
// MARK: Dynamic Call
//***********************************************//
extension PushNotificationHandler {
    func moveToMenusAccordingToData(data:[String:Any]){
        if let payld = data["payload"] as? [String:Any] {
            if  let receiverType = payld["receiver_type"] as? String {
                if receiverType == "S" {
                    if  UserModel.getObject().id.isEmpty {
                       // AppDelegate.shared.setRootViewController(vc: .Login)
                        return
                    }
                    
                    var index = -1
                    if let ind = payld["aap_redirect_page_id"] as? String, ind.isEmpty == false {
                        index = Int(ind)!
                    }
                    
                    if let ind = payld["aap_redirect_page_id"] as? Int  {
                        index = ind
                    }

              UserDefaults.standard.set(index, forKey: "sIndex")
                    AppSession.share.isForHomeRedirection = true
              AppDelegate.shared.setRootViewController(vc: .Home)
                    
                }

            }
        }
    }
}
extension AppDelegate {
    //===========================================================
    //MARK: - Notification Method
    //===========================================================
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        PushNotificationHandler.instance.gettingPushNotificationToken(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> ()){
        print("Notification Receive:\(userInfo)")
        
        

         Messaging.messaging().appDidReceiveMessage(userInfo)

        
        PushNotificationHandler.instance.didReceivePushNotificationData(userInfo)
    }
}
//===========================================================
//MARK: - UNUserNotificationCenterDelegate Methods
//===========================================================
extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Tapped in notification")
        print(response.notification.request.content.userInfo)
        PushNotificationHandler.instance.didReceivePushNotificationData(response)
        completionHandler()
    }
    //This is key callback to present notification while the app is in foreground
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler( [.alert,.sound,.badge])
    }
}

