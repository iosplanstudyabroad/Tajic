//
//  ReferFriendPopUpVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

protocol  referDelegate {
    func refercenceUpdated(_ referCount:Int)
}
class ReferFriendPopUpVC: UIViewController {
    @IBOutlet weak var supportView:UIView!
    @IBOutlet weak var nameBackView:UIView!
    @IBOutlet weak var name:UITextField!
    @IBOutlet weak var emailBackView:UIView!
    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var phoneBackView:UIView!
    @IBOutlet weak var phone:UITextField!
    var delegate:referDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure(){
        supportView.cardView()
        supportView.cornerRadius(10)
        nameBackView.border(1, borderColor: UIColor().themeColor())
        nameBackView.cornerRadius(10)
        emailBackView.border(1, borderColor: UIColor().themeColor())
        emailBackView.cornerRadius(10)
        phoneBackView.border(1, borderColor: UIColor().themeColor())
        phoneBackView.cornerRadius(10)
        
    }
    
    @IBAction func referFriendBtnTapped(_ sender:UIButton){
        if validation() {
           referFriendCall()
        }
    }
    
    @IBAction func closeBtnTapped(_ sender:UIButton){
        self.remove()
    }
}


extension ReferFriendPopUpVC {
    func validation()-> Bool {
        if name.text!.isEmpty {
            showAlertMsg(msg: "Please enter Name")
            return false
        }
        if email.text!.isEmpty {
          showAlertMsg(msg: "Please enter valid email id")
            return false
        }
         if email.text!.isValidEmail == false  {
            showAlertMsg(msg: "Email is not in proper format")
            return false
            }
        if phone.text!.isEmpty {
           showAlertMsg(msg: "Please enter Mobile No")
            return false
        }
        return true
    }
}

extension ReferFriendPopUpVC {
    private func referFriendCall() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        
        
        
        let  params = ["user_id":model.id,"app_agent_id":model.agentId,"email":email.text!,"mobile_number":phone.text!,"name":name.text!] as [String : Any]
      
       
        ActivityView.show()
        WebServiceManager.instance.referFriend(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let code = json["Code"] as? Int,code ==  200 {
                    if let payload = json["Payload"] as? [String:Any], let count = payload["referred_count"] as? Int{
                        self.delegate?.refercenceUpdated(count)
                         ActivityView.hide()
                        self.remove()
                    }
                    
                    if let msg =  json["Message"] as? String,msg.isEmpty == false  {
                         ActivityView.hide()
                     self.showAlertMsg(msg:msg)
                       /* DispatchQueue.main.async {
                            self.isClear = true
                            let model = ReferModel()
                             self.referArray[0] = model
                            if self.sectionOneCellCount == 1 {
                                let model = ReferModel()
                                self.referArray[1] = model
                            }
                            
                            if self.sectionTwoCellCount == 1 {
                                let model = ReferModel()
                                self.referArray[2] = model
                            }
                            self.table.reloadData()
                        }
                       */
                       return
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
