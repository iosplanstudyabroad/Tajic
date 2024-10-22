//
//  StudentDashBoardViewModel.swift
//  Unica New
//
//  Created by UNICA on 09/10/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class StudentDashBoardViewModel: NSObject {
    func getMenu(block:@escaping(_ menuArray:[MenuModel])->Swift.Void){
        getMenuDetails(block: block)
    }
    func getBanners(block:@escaping(_ bannerArray:[BannerModel])-> Swift.Void){
       getBannerList(block: block)
    }
    
    func getDocumentsList(block:@escaping(_ bannerArray:[DocumentModel])-> Swift.Void){
        documentsList(block: block)
    }
    
    func getAppConfigurationDetails(block:@escaping(_ bannerArray:[String:Any])-> Swift.Void){
        getAppConfiguration(block: block)
    }
    
    func unreadCount(block:@escaping(_ count:Int)-> Swift.Void){
        unreadCountList(block: block)
    }
    //get-agency.php
    func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}
extension StudentDashBoardViewModel {
    
  private  func getAppConfiguration(block:@escaping(_ configArray:[String:Any])-> Swift.Void){
      guard StaticHelper.isInternetConnected else {
          showAlertMsg(msg: AlertMsg.InternectDisconnectError)
          return
      }
    let dict = [String:Any]()
      ActivityView.hide()
      ActivityView.show()
      WebServiceManager.instance.getAppConfiguration() { (status, json) in
          switch status {
          case StatusCode.Success:
              if let payload = json["Payload"] as? [String:Any]{
                block(payload)
              }
              else{
                   block(dict)
                //  self.showAlertMsg(msg: json["Message"] as! String)
              }
              ActivityView.hide()
          case StatusCode.Fail:
               block(dict)
              ActivityView.hide()
              self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
          case StatusCode.Unauthorized:
               block(dict)
              ActivityView.hide()
              self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
          default:
              break
          }
      }
  }
       
    
  private func unreadCountList(block:@escaping(_ count:Int)-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let id = UserModel.getObject().id
        let params = ["user_type":"S","user_id":id,"app_agent_id":UserModel.getObject().agentId,]
        var tempBannerArray = [BannerModel]()
    var counter = 0
        ActivityView.hide()
        ActivityView.show()
        WebServiceManager.instance.studentUnReadNotificationCountWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let payLoad = json["Payload"] as? [String:Any]{
                    if let count = payLoad["unread_notification_count"] as? Int {
                      block(count)
                    }
                  
                    if let count = payLoad["unread_notification_count"] as? Int {
                        let countNumber = Int(count)
                   block(countNumber)
                }
                }
                else{
                     block(counter)
                    self.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                 block(counter)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                 block(counter)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    private func getBannerList(block:@escaping (_ bannerArray:[BannerModel])-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let id = UserModel.getObject().id
        let params = ["user_type":"S","user_id":id,"app_agent_id":UserModel.getObject().agentId,]
        var tempBannerArray = [BannerModel]()
        ActivityView.hide()
        ActivityView.show()
        WebServiceManager.instance.studentGetBannersWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let bannerArray = json["Payload"] as? [[String:Any]],bannerArray.isEmpty == false {
                  //  UserDefaults.standard.set(bannerArray, forKey: "Banners")
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

    private func getMenuDetails(block:@escaping(_ menuArray:[MenuModel])->Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let userId = UserModel.getObject().id
        let  params = ["user_id":userId,"app_agent_id":UserModel.getObject().agentId,]
        
       var  tempMenuArray = [MenuModel]()
        ActivityView.show()
        WebServiceManager.instance.studentGetLeftAndDashBoardMenuWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                   // UserDefaults.standard.set(data, forKey: "menu")
                    if let infoArray = data["general_info_links"] as? [[String:Any]]{
                        var array =   [GeneralInfoModel]()
                       
                        
                            
                        infoArray.forEach({ (dict) in
                            let model = GeneralInfoModel(with: dict)
                            array.append(model)
                        })
                        AppSession.share.generalInfoArray = array
                    }
                    
                    
                    if let menuArray = data["menus"] as? [[String:Any]]  {
                        var localArray = [MenuModel]()
                    
                        
                        
                        
                        menuArray.forEach({ (menuDict) in
                            let model = MenuModel(with: menuDict)
                          if   model.rowNumber == 4 && model.leftMenuTitle == "Application" {
                            model.leftMenuTitle = "Track Application"
                            }
                               localArray.append(model)
                            
                        })
                        AppSession.share.menuArray = localArray.filter({ (mod) -> Bool in
                            if mod.visibleOnSlider{
                                return true
                            }else{
                                return false
                            }
                        })
                        
                        var array  = localArray.filter({ (mod) -> Bool in
                            if mod.visibleOnDashBoard {
                                return true
                            }else{
                                return false
                            }
                        })
                        
                        array.removeAll(where: { (mod) -> Bool in
                            if mod.subMenu.isEmpty == false{
                                return true
                            }
                            return false
                        })
                        tempMenuArray = array
                        self.saveMenudata(menu:array)
                        block(tempMenuArray)
                    }
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                     block(tempMenuArray)
                }
                ActivityView.hide()
             case StatusCode.Fail:
                ActivityView.hide()
                 block(tempMenuArray)
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                 block(tempMenuArray)
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
     func calculateHeight(_ eventArray:[MenuModel])->CGFloat {
        if eventArray.isEmpty {
            return 0
        }
        let numberOfEvent = eventArray.count
        if numberOfEvent % 2 == 0 {
            var height = (numberOfEvent/2)*100
            height     += 70
            return CGFloat(height)
        }
        if numberOfEvent % 2 == 1 {
            let eventCount = numberOfEvent+1
            var height = (eventCount/2)*100
            height += 70
            return CGFloat(height)
        }
        return 0
    }
}

extension StudentDashBoardViewModel {
    func getMenuOffLine(block:@escaping(_ menuArray:[MenuModel])->Swift.Void){
         var  tempMenuArray = [MenuModel]()
        if let data = UserDefaults.standard.object(forKey:"menu" ) as? [String:Any] {
        
        if let infoArray = data["general_info_links"] as? [[String:Any]]{
            var array =   [GeneralInfoModel]()
            infoArray.forEach({ (dict) in
                let model = GeneralInfoModel(with: dict)
                array.append(model)
            })
            AppSession.share.generalInfoArray = array
        }
        
        
        if let menuArray = data["menus"] as? [[String:Any]]  {
            var localArray = [MenuModel]()
            menuArray.forEach({ (menuDict) in
                let model = MenuModel(with: menuDict)
                
                   localArray.append(model)
                
            })
            AppSession.share.menuArray = localArray.filter({ (mod) -> Bool in
                if mod.visibleOnSlider{
                    return true
                }else{
                    return false
                }
            })
            
            var array  = localArray.filter({ (mod) -> Bool in
                if mod.visibleOnDashBoard {
                    return true
                }else{
                    return false
                }
            })
            
            array.removeAll(where: { (mod) -> Bool in
                if mod.subMenu.isEmpty == false{
                    return true
                }
                return false
            })
            tempMenuArray = array
            block(tempMenuArray)
        }
    }}
    
    func getOfflineBanners(block:@escaping (_ bannerArray:[BannerModel])-> Swift.Void){
        var tempBannerArray = [BannerModel]()
        if let bannerArray = UserDefaults.standard.object(forKey: "Banners") as? [[String:Any]],bannerArray.isEmpty == false {
            bannerArray.forEach({ (dict) in
                let banner = BannerModel(with: dict)
                tempBannerArray.append(banner)
            })
          block(tempBannerArray)
        }else{
         block(tempBannerArray)
        }
    }
}

extension StudentDashBoardViewModel {
    private func documentsList(block:@escaping(_ documentsArray:[DocumentModel])-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_type":"S","user_id":model.id]
        var tempDocArray = [DocumentModel]()
        ActivityView.hide()
        ActivityView.show()
        WebServiceManager.instance.getDocumentsListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let payload = json["Payload"] as? [String:Any]{
                    self.configureAgentDetails(payload)
                   if let docArray = payload["uploded_documents"] as? [[String:Any]],docArray.isEmpty == false  {
                    docArray.forEach({ (dict) in
                        let docModel = DocumentModel(with: dict)
                        tempDocArray.append(docModel)
                    })
                  block(tempDocArray)
                }else{
                     block(tempDocArray)
                    self.showAlertMsg(msg: json["Message"] as! String)
                    }}
                ActivityView.hide()
            case StatusCode.Fail:
                 block(tempDocArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                 block(tempDocArray)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
}
extension StudentDashBoardViewModel {
    /*
  

             $deviceToken
             $user_id
             app_agent_id
            
     
     
     */
    func updateToken(block:@escaping(_ documentsArray:[String:Any])-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let temp = [String:Any]()
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id":model.id,"deviceToken" :PushNotificationHandler.deviceToken,"deviceType":"I"]
      
        WebServiceManager.instance.updateDeviceToken(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                block(temp)
               /* if let payload = json["Payload"] as? [String:Any]{
                   block(payload)
                }*/
                ActivityView.hide()
            case StatusCode.Fail:
                 block(temp)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                 block(temp)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    
}
extension StudentDashBoardViewModel{
    func configureAgentDetails(_ dict:[String:Any]){
        if let name = dict["app_agent_name"] as? String {
           AppSession.share.agentName = name
        }
        if let mobile = dict["app_agent_whatsup"] as? String {
             AppSession.share.agentMobile = mobile
        }
        
        if let whatsApp = dict["app_agent_whatsup"] as? String {
           AppSession.share.agentWhatsup = whatsApp
        }
        
        if let mobile = dict["app_agent_mobile"] as? Int {
            AppSession.share.agentMobile = String(mobile)
        }
          
        if let mobile = dict["app_agent_mobile"] as? String {
                  AppSession.share.agentMobile = mobile
              }
        
        if let whatsApp = dict["app_agent_whatsup"] as? Int {
             AppSession.share.agentWhatsup = String(whatsApp)
        }
        
    }
}




extension StudentDashBoardViewModel {
    func saveMenudata(menu:[MenuModel]){
        let model = MenuArrayModel()
        model.menuList = menu
            let encoder = JSONEncoder()
            guard let jsonData = try? encoder.encode(model) else {
                return
            }
            UserDefaults.standard.set(jsonData, forKey: "menu")
            UserDefaults.standard.synchronize()
    
            }
    
 func getSavedMenuData(block:@escaping(_ menuArray:MenuArrayModel)->Swift.Void)  {
        if let data = UserDefaults.standard.data(forKey: "menu") {
            guard let menuArray = try? JSONDecoder().decode(MenuArrayModel.self, from: data) else {
                let model =  MenuArrayModel()
               return    block(model)
            }
            AppSession.share.menuArray = menuArray.menuList
            block(menuArray)
        }
        let model =  MenuArrayModel()
    block(model)
    }
}



class MenuArrayModel: NSObject,Codable {
    var menuList = [MenuModel]()
    
}
