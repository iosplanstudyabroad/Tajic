//
//  DocumentsVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class DocumentsVC: UIViewController {

    @IBOutlet var agentName: UILabel!
    @IBOutlet var callBtn: UIButton!
    var documentArray = [DocumentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func configure(){
        setupNavigation()
        callBtn.border(0, borderColor: UIColor().themeColor())
        callBtn.cornerRadius(10)
        
        agentName.text = "Your Counsellor : \(AppSession.share.agentName)" 
    }
    
    @IBAction func backBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func whatsAppBtnTApped(_ sender: UIButton) {
        let what = AppSession.share.agentWhatsup
        if what.isEmpty == false {
         openWhatsapp(what,"")
        }
    }
    
    @IBAction func uploadDocumentBtnTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocumentsListVC") as? DocumentsListVC {
           // vc.documentList = documentArray
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func callBtnTapped(_ sender:UIButton){
        let phone = AppSession.share.agentMobile
        if phone.isEmpty == false {
           callNumber(phoneNumber: phone)
        }
    }
}

extension DocumentsVC {
    
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
extension DocumentsVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 180, height: 45))
         titleLbl.text = "Documents Available"
        titleLbl.textColor = UIColor.white
        titleLbl.font = .systemFont(ofSize: 18)
        leftView.addSubview(titleLbl)
        let rightView = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 45))
        let chatBtn                                        = UIButton(type: .custom)
        chatBtn.frame                                      = CGRect(x: 0, y: 0, width: 45, height: 45)
        rightView.addSubview(chatBtn)
        let rightMenuBtn                                        = UIButton(type: .custom)
       // rightMenuBtn.setImage(UIImage(named: "bell.png"), for: .normal)
       // rightMenuBtn.addTarget(self, action: #selector(callBtnTapped), for: .touchUpInside)
        rightMenuBtn.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
        let unreadLabl = UILabel()
        unreadLabl.frame = CGRect(x: 20, y: 0, width: 26, height: 26)
        unreadLabl.textColor           = UIColor.clear
        unreadLabl.backgroundColor     = UIColor.clear
    
       // let rightBarBtn                                         = UIBarButtonItem(customView: rightView)
      //  self.navigationItem.rightBarButtonItem                  = rightBarBtn
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}
