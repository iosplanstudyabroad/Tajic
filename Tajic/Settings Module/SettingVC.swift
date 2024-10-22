//
//  SettingVC.swift
//  CampusFrance
//
//  Created by UNICA on 14/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import GoogleSignIn
class SettingVC: UIViewController {
    @IBOutlet var gradinentVIew: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftMenuBtnOnNavigation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension SettingVC {
    @IBAction func menuBtnTapped(_ sender: Any) {
       slideMenuController()?.openLeft()
    }
    
    func addLeftMenuBtnOnNavigation(){
        gradinentVIew.setGradientColor()
        self.navigationController?.configureNavigation()
        let button                            = UIButton(type: .custom)
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
        button.frame                          = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView                          = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(button)
        let titleLbl                          = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text                         = "Settings"
        titleLbl.textColor                    = UIColor.white
        leftView.addSubview(titleLbl)
        let barButton                         = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = barButton
    }
}

//***********************************************//
// MARK: UITable Methods Defined Here
//***********************************************//
extension SettingVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell         = tableView.dequeueReusableCell(withIdentifier: "SettingCommonCell") as! SettingCommonCell
        cell.configureCell(index: indexPath.row)
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:LogOut()
        default:return 
            
        }
    }
}

//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension SettingVC {
    func LogOut() {
        let alert = UIAlertController(title: "", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        let noBtn = UIAlertAction(title: "No", style: .default, handler:nil)
        let yesBtn = UIAlertAction(title: "YES", style: .default) { (action) in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                if let user =  UserDefaults.standard.object(forKey:UDConst.userLoginType) as? String, user == "Stu" {
                    UserModel.clear()
                }else{
                }
                 UserModel.clear()
                
                GIDSignIn.sharedInstance.signOut()
                AppSession.share.logoutFB()
               
                AppDelegate.shared.setRootViewController(vc: .Login)
            })
        }
        alert.addAction(noBtn)
        alert.addAction(yesBtn)
       self.present(alert, animated: true, completion: nil)
    }
}
