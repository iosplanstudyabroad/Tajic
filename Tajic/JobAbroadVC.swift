//
//  JobAbroadVC.swift
//  Tajic
//
//  Created by Mohit Kumar  on 07/03/22.
//  Copyright © 2022 Unica Solutions. All rights reserved.
//

import UIKit

class JobAbroadVC: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var titleString = ""
    var isDownloadEnable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure(){
        if AppSession.share.jobUrl.isEmpty {
            self.getJobDetails()
        }else{
            configureWeb(AppSession.share.jobUrl)
        }
    }
    
    func configureWeb(_ urlString:String){
        
        if StaticHelper.isInternetConnected {
            webView.navigationDelegate = self
            if urlString.contains(" ") {
                if  let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    if let url = URL(string:urlStr) {
                        let request = URLRequest(url:url )
                        webView.load(request)
                        ActivityView.show()
                    }
                }
            }
            if let url = URL(string:urlString) {
                let request = URLRequest(url:url )
                webView.load(request)
                ActivityView.show()
            }
        }else{
            showAlertMsg(msg:AlertMsg.InternectDisconnectError)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addLeftMenuBtnOnNavigation()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func callBtnTapped(_ sender:UIButton){
        let phone = AppSession.share.jobPhoneNumber
        if phone.isEmpty == false {
           callNumber(phoneNumber: phone)
        }else{
            showAlertMsg(msg: "Mobile number is not present")
        }
    }
    
    
    @IBAction func whatsAppBtnTApped(_ sender: UIButton) {
           let what = AppSession.share.agentWhatsup
           if what.isEmpty == false {
            openWhatsapp(what,"")
           }else{
           showAlertMsg(msg: "Whatsapp number is not present")
        }
       }
}

extension JobAbroadVC {
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
    
}

extension JobAbroadVC:WKNavigationDelegate{
     func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard
                let url = navigationAction.request.url,
                let scheme = url.scheme else {
                    decisionHandler(.cancel)
                    return
            }

            if (scheme.lowercased() == "mailto") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                // here I decide to .cancel, do as you wish
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityView.hide()
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-100, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: self.view.frame.size.width-110, height: 45))
        titleLbl.text = titleString
        if titleString.isEmpty {
            titleLbl.text = "Job Abroad"
        }
        
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = barBtn
    }
}


extension JobAbroadVC {
    
    func getJobDetails(){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        
        let userId = UserModel.getObject().id
        
        let params = ["user_id":userId,"app_agent_id":UserModel.getObject().agentId]
        
        ActivityView.show()
        WebServiceManager.instance.getjobsWithDetails(params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any], let job = data["job_abroad"] as? [String:Any] {
                    if let actionUrl = job["action_url"] as? String {
                        AppSession.share.jobUrl = actionUrl
                        self.configureWeb(actionUrl)
                    }
                    
                    if let phone = job["contact_number"] as? String {
                        AppSession.share.jobPhoneNumber = phone
                    }
                    
                    if let whatsapp = job["whatsapp_number"] as? String {
                        AppSession.share.jobWhatsAppNumber = whatsapp
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
            default:break
            }
        }
    }
    
    
    
}
