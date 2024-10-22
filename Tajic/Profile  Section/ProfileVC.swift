//
//  ProfileVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    
    var profileModel = ProfileEnquiryModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
       configure()
    }
    
    func configure(){
      setupNavigation()
       
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppSession.share.registerModel = RegistrationModel()
        AppSession.share.multiCountryList.removeAll()
        profileModel = ProfileEnquiryModel()
        self.table.reloadData()
        if StaticHelper.isInternetConnected {
           getProfileDetails()
        }else{
            offLineSetup()
        }
         
    }
    
    @IBAction func updateProfileBtnTapped(_ sender:UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentEditUserProfileVC") as? StudentEditUserProfileVC {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func leftmenuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
  @IBAction func  callBtnTapped(_ sender:UIButton){
     
  }
  
}

extension ProfileVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        
         titleLbl.text = "Profile Details"
        
        
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
extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return configureBasicInfoCell(tableView, index: indexPath)
        case 1:return configureQRCodeCell(tableView, index: indexPath)
            //return configureEnquryInfoCell(tableView, index: indexPath)
        default:return configureQRCodeCell(tableView, index: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 190
        case 1: return 450 //UITableView.automaticDimension
        default: return 450
        }
    }
}
extension ProfileVC {
    func configureBasicInfoCell(_ table: UITableView, index: IndexPath)-> ProfileBasicInfoCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProfileBasicInfoCell") as! ProfileBasicInfoCell
        cell.configure(profileModel)
        return cell
    }
    
    func configureEnquryInfoCell(_ table: UITableView, index: IndexPath)-> ProfileEnquiryInfoCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProfileEnquiryInfoCell") as! ProfileEnquiryInfoCell
        cell.configure(profileModel)
        return cell
    }
    
    func configureQRCodeCell(_ table: UITableView, index: IndexPath)-> ProfileQRCodeCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ProfileQRCodeCell") as! ProfileQRCodeCell
        cell.configure(profileModel)
        return cell
    }
}

extension ProfileVC {
func getProfileDetails(){
    guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg: AlertMsg.InternectDisconnectError)
        return
    }
    let id = UserModel.getObject().id
    let params = ["user_id":id,"app_agent_id":UserModel.getObject().agentId,]
    ActivityView.show()
    WebServiceManager.instance.studentGetInquiryWithDetails(params: params) { (status, json) in
        switch status {
        case StatusCode.Success:
            if let data = json["Payload"] as? [String:Any] {
//
//                let result = data.filter { $0.value != nil }.mapValues { $0 }
//                print(result)
             //   UserDefaults.standard.set(result, forKey: "profile")
               let model = ProfileEnquiryModel(with: data)
                self.profileModel = model
                self.table.reloadData()
                ActivityView.hide()
            }
            else{
                self.showAlertMsg(msg: json["Message"] as! String)
                ActivityView.hide()
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
extension ProfileVC {
    func offLineSetup() {
//        if let data = UserDefaults.standard.object(forKey: "profile") as? [String:Any] {
//            let model = ProfileEnquiryModel(with: data)
//             self.profileModel = model
//             self.table.reloadData()
//        }
    }
    
    func conversionOfData(data:[String:Any]){
        
    }
}


/*
 {
     "app_agent_id" = 17;
     "apply_course_type_id" = "<null>";
     "apply_course_type_title" = "Part Time";
     "course_intake" = "";
     email = "unitreeapp@gmail.com";
     firstname = Uni;
     "interested_category_id" =     (
         70
     );
     "interested_category_title" =     (
         "International Business"
     );
     "interested_country" =     (
         102
     );
     "interested_country_title" =     (
                 {
             id = 102;
             name = India;
         }
     );
     "interested_year" = 2021;
     lastname = Tree;
     mobileNumber = 9876784987;
     "unica_student_code" = RYTVV;
     userid = "5FzI4u3Vn4d7yvZr2cnMUue7rKq9idfEiRgM29ui++c=";
 }
 
 
 
 
 */
