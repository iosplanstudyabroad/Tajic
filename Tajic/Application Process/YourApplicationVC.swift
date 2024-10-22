//
//  YourApplicationVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class YourApplicationVC: UIViewController {
    @IBOutlet weak var supportView:UIView!
    @IBOutlet weak var table:UITableView!
    var pageTitle = ""
    var appList = [ApplicationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func configure(){
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        setupNavigation()
        getApplicationList()
    }
    @IBAction func callBtnTapped(_ sender: Any) {
        let phone = AppSession.share.agentMobile
        if phone.isEmpty == false {
           callNumber(phoneNumber: phone)
        }
       
    }
    
    @IBAction func whatsAppBtnTapped(_ sender: Any) {
        let what = AppSession.share.agentWhatsup
        if what.isEmpty == false {
         openWhatsapp(what,"")
        }
        
    }
    
   @IBAction func  leftmenuBtnTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
     }
}

extension YourApplicationVC {
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
                    self.showAlertMsg(msg: "Install Whatsapp")
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    private func callNumber(phoneNumber:String) {
        var number = phoneNumber.replacingOccurrences(of: "+", with: "")
             number = number.replacingOccurrences(of: " ", with: "")
      if let phoneCallURL = URL(string: "tel://\(number)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}

extension YourApplicationVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = pageTitle
        if pageTitle.isEmpty {
            titleLbl.text = "Your Application"
        }
         
        

        titleLbl.textColor = UIColor.white
        titleLbl.font = .systemFont(ofSize: 18)
        leftView.addSubview(titleLbl)
        let rightView = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 45))
        let chatBtn                                        = UIButton(type: .custom)
      //  chatBtn.setImage(UIImage(named: "bell.png"), for: .normal)
       // chatBtn.addTarget(self, action: #selector(chatBtnTapped), for: .touchUpInside)
        chatBtn.frame                                      = CGRect(x: 0, y: 0, width: 45, height: 45)
        
        rightView.addSubview(chatBtn)
        let rightMenuBtn                                        = UIButton(type: .custom)
        rightMenuBtn.setImage(UIImage(named: "bell.png"), for: .normal)
        rightMenuBtn.addTarget(self, action: #selector(callBtnTapped), for: .touchUpInside)
        rightMenuBtn.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
        
        
        
       // rightView.addSubview(rightMenuBtn)
        let unreadLabl = UILabel()
        unreadLabl.frame = CGRect(x: 20, y: 0, width: 26, height: 26)
        unreadLabl.textColor           = UIColor.clear
        unreadLabl.backgroundColor     = UIColor.clear
        rightView.addSubview(unreadLabl)
        let rightBarBtn                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = rightBarBtn
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}

extension YourApplicationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appList.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureAppCell(tableView, indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = appList[indexPath.row]
        model.isShowCourse = true
      moveToDetails(model)
    }
    
    
    func moveToDetails(_ model:ApplicationModel){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC{
            vc.isFormFeature = model.isFromFeature
            vc.instituteID = model.instituteId
            vc.courseId    = model.courseId
            vc.isShowCourse = model.isShowCourse
            self.navigationController!.pushViewController(vc, animated: false)
        }
    }
}


extension YourApplicationVC:appProtocol {
    
    func configureAppCell(_ table: UITableView, _ index: IndexPath)-> appCell {
        let cell = table.dequeueReusableCell(withIdentifier: "appCell") as! appCell
        cell.delegate = self
        cell.configure(appList[index.row])
        return cell
    }
    func instituteNameTapped(_ model: ApplicationModel) {
        moveToDetails(model)
    }
}


extension YourApplicationVC{
private func getApplicationList() {
    guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg: AlertMsg.InternectDisconnectError)
        return
    }
    let model  = UserModel.getObject()
    let  params = ["app_agent_id":model.agentId,"user_id":model.id] as [String : Any]
  
   
    ActivityView.show()
    WebServiceManager.instance.applicationList(params: params) { (status, json) in
        switch status {
        case StatusCode.Success:
            if let code = json["Code"] as? Int,code ==  200 {
              if  let payLoad = json["Payload"] as? [String:Any]{
                if let appList = payLoad["Status"] as? [[String:Any]], appList.isEmpty == false  {
                    appList.forEach { (dict) in
                        let model = ApplicationModel(dict)
                        self.appList.append(model)
                    }
                    DispatchQueue.main.async {
                      self.table.reloadData()
                        self.supportView.isHidden = false
                        self.table.isHidden = false
                    }
                }else{
                    self.supportView.isHidden = true
                    self.table.isHidden = true
                }
                }
            }
            else{
                self.showAlertMsg(msg: json["Message"] as! String)
                 
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
