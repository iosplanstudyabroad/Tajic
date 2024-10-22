//
//  NotificationVC.swift
//  CampusFrance
//
//  Created by UNICA on 03/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var gradinentVIew:GradientView!
    @IBOutlet  var tableView:UITableView!
    var notificationArray    = [NotificationModel]()
    var actionModel          = NotificationModel()
    var isActionSeleted      = false
    var selectedAction       = ""
    var pagingCounter        = 1
    var isFetchingNextPage   = true
    var userType             = ""
    var notificationId       = ""
    var userId               = ""
    var notificationUserType = ""
    var isFromPush           = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
        
    }
    
    func configure(){
        tableView.rowHeight          = 80
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.prefetchDataSource = self
       getNotifications(pagingCounter: pagingCounter)
        addLeftMenuBtnOnNavigation()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

extension NotificationVC:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard notificationArray.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.notificationArray.count-1 }
        if needsFetch && isFetchingNextPage {
           getNotifications(pagingCounter:self.pagingCounter)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureNotificationCell(indexPath:indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         unreadTapped(index: indexPath.row)
        switch notificationArray[indexPath.row].notificationCategory {
    case 2:self.webPageRedirect(url:notificationArray[indexPath.row].urlToRedirect)
        case 3:self.moveToDetials(index: notificationArray[indexPath.row].index)
        default:break
        }
    }
    
    
    
    func webPageRedirect(url:String){
        if url.isEmpty == false && url.isValidURL {
            if let rUrl = URL(string: url){
                UIApplication.shared.open(rUrl, options: [:], completionHandler: nil)
            }
        }
    }
    func moveToDetials(index:Int){
        AppSession.share.menuArray.forEach { (model) in
            if model.rowNumber == index {
                self.moveToViewController(model: model)
                
            }
        }
    }
 
}


extension NotificationVC {
    func moveToViewController(model:MenuModel){
        defer {
            slideMenuController()?.closeLeft()
        }
        switch model.rowNumber {
        case 1:print("Home Tapped")
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            nav.popToRootViewController(animated: true)
            return
            }
        case 2:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is ProfileVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            nav.pushViewController(vc, animated: true)
        }}
            case 3:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is SearchCourseVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchCourseVC") as? SearchCourseVC {
                nav.pushViewController(vc, animated: true)
            }}//YourApplicationVC
            case 4:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is YourApplicationVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourApplicationVC") as? YourApplicationVC {
                nav.pushViewController(vc, animated: true)
            }}
            case 5:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                       if nav.topViewController is SortListedCourseVC {
                           return
                       }
                       if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShortListVC") as? ShortListVC {
                           nav.pushViewController(vc, animated: true)
                       }}
            
            case 6:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                                  if nav.topViewController is ReferFriendVC {
                                      return
                                  }
                                  if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendVC") as? ReferFriendVC {
                                      nav.pushViewController(vc, animated: true)
                                  }}
            case 7:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                       if nav.topViewController is CountryOfStudyVC {
                           return
                       }
                       if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryOfStudyVC") as? CountryOfStudyVC {
                           nav.pushViewController(vc, animated: true)
                       }}
            
        case 8:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is ReachUsVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReachUsVC") as? ReachUsVC {
            nav.pushViewController(vc, animated: true)
        }}
        
            case 9:let  filterArray = AppSession.share.documentArray.filter{(dModel) -> Bool in
                (dModel.isUploaded) == true
            }
            if filterArray.isEmpty {
                moveToNoDocuments()
            }else{
               moveToDocumentList()
            }
            
            case 10: if model.linkOpenType == "Web" {
                commonWeb(model:model)
            }
            
            case 11:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is CountryOfStudyVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LatestEventsVC") as? LatestEventsVC {
                nav.pushViewController(vc, animated: true)
            }}
            
            case 12:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is GeneralInfoVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GeneralInfoVC") as? GeneralInfoVC {
                nav.pushViewController(vc, animated: true)
            }}
        case 13: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is SettingVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as? SettingVC {
            nav.pushViewController(vc, animated: true)
        }}
  default:break
 
        }}
    
    
    func moveToNoDocuments(){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is DocumentsVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentsVC") as? DocumentsVC {
            nav.pushViewController(vc, animated: true)
        }
            
        }
    }
    func moveToDocumentList(){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is DocumentsListVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentsListVC") as? DocumentsListVC {
            nav.pushViewController(vc, animated: true)
        }
            
        }
    }
    
    
    func commonWeb(model:MenuModel){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
            vc.titleString = model.leftMenuTitle
            vc.urlString = model.url
            nav.pushViewController(vc, animated: true)
           
            }}
        
    }
    
}


extension NotificationVC{
    private func configureNotificationCell(indexPath:IndexPath,tableView:UITableView) -> NotificationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        cell.layoutIfNeeded()
        
        cell.selectionStyle = .none
        cell.configureCell(model: notificationArray[indexPath.row])
       
        return cell
    }
    
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        unreadTapped(index:sender.tag)
    }
    
    @IBAction func noBtnTapped(_ sender: UIButton) {
       
        unreadTapped(index:sender.tag)
    }
    
    func unreadTapped(index:Int){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            self.readNotification(index:index, nModel: self.notificationArray[index])
        }
    }
}


extension NotificationVC {
    @IBAction func backBtnTapped(_ sender: Any) {
        if isFromPush {
            if UserModel.getObject().id.isEmpty == false {
                AppDelegate.shared.setRootViewController(vc: .Home)
                return
            }
             AppDelegate.shared.setRootViewController(vc: .Login)
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addLeftMenuBtnOnNavigation(){
        gradinentVIew.setGradientColor()
        self.navigationController?.configureNavigation()
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        button.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(button)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = "Notifications"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = barButton
    }
}


extension NotificationVC{
    func getNotifications(pagingCounter:Int) {
         self.tableView.prefetchDataSource = self
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
         let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
        ,"user_type":model.userType]
        
        
         params["page_number"] = String(pagingCounter)
       
        //ActivityView.show()
        WebServiceManager.instance.studentGetNotificationListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                
                if let codeString = json["Code"] as? Int, codeString == 404    {
                    if pagingCounter == 1 {
                        if let msg = json["Message"] as? String {
                           self.showAlertMsg(msg:msg )
                        }
                        
                    }
                  return
                }
                if let data = json["Payload"] as? [String:Any], let notiArray = data["messages"] as? [[String:Any]],notiArray.isEmpty == false {
                    
                    for (index, dict) in notiArray.enumerated() {
                        let model = NotificationModel(with: dict)
                        self.notificationArray.append(model)
                        print(" Index of notificaton array \(index)")
                    }
                   
                    DispatchQueue.main.async {
                        self.pagingCounter += 1
                        self.isFetchingNextPage = true
                        if self.pagingCounter == 2 {
            self.getNotifications(pagingCounter:self.pagingCounter)
                        }
                      self.tableView.reloadData()
                    }
                }
                else{
                 //   self.showAlertMsg(msg: json["Message"] as! String)
                    self.pagingCounter = 1
                    self.isFetchingNextPage = false
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
    
    func readNotification(index:Int,nModel:NotificationModel) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        var params = [String:Any]()
       
     
        let model = UserModel.getObject()
        params = ["app_agent_id":model.agentId,"userid": model.id,"notificationId":nModel.id]
        
        WebServiceManager.instance.readNotificationWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let code = json["Code"] as? Int, code == 404 {
                   // self.showAlertMsg(msg: json["Message"] as! String)
                    ActivityView.hide()
                    return
                }
                if self.tableView != nil {
                    self.notificationArray[index].isUnread = false
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
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
/// notificationAcceptRejectRequestWithDetails
