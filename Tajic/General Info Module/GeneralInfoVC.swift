//
//  GeneralInfoVC.swift
//  CampusFrance
//
//  Created by UNICA on 10/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
class GeneralInfoVC: UIViewController {
    @IBOutlet var gradinentVIew: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftMenuBtnOnNavigation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //***********************************************//
    // MARK: Menu Btn Tapped
    //***********************************************//
    @IBAction func menuBtnTapped(_ sender: Any) {
        slideMenuController()?.openLeft()
    }
}

//***********************************************//
// MARK: Add Custom Buttons on Navigation
//***********************************************//
extension GeneralInfoVC {
    func addLeftMenuBtnOnNavigation(){
        gradinentVIew.setGradientColor()
        self.navigationController?.configureNavigation()
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(button)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = "General Info"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = barButton
    }
}

//***********************************************//
// MARK: UITable Methods Defined Here
//***********************************************//
extension GeneralInfoVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppSession.share.generalInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell         = tableView.dequeueReusableCell(withIdentifier: "GeneralInfoCell") as! GeneralInfoCell
        cell.configureCell(model:AppSession.share.generalInfoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if AppSession.share.generalInfoArray[indexPath.row].link.isEmpty == false {
            if let nav = self.slideMenuController()?.mainViewController as? UINavigationController {
                if  let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as? CommonWebVC {
                    vc.titleString = AppSession.share.generalInfoArray[indexPath.row].title
                    vc.urlString = AppSession.share.generalInfoArray[indexPath.row].link
                    nav.pushViewController(vc, animated: false)
                }
            }
        }
    }
}
