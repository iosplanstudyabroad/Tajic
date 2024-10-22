//
//  ReferFriendVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReferFriendVC: UIViewController {
    @IBOutlet weak var referLabel:UILabel!
    @IBOutlet var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var table:UITableView!
    @IBOutlet var   referFreindBtn:UIButton!
    var sectionOneCellCount = 0
    var sectionTwoCellCount = 0
    var referArray          = [ReferStudentModel]()
    var isClear             = false
    var maxReferCount       = 0
    var referCount          = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func configure(){
       setupNavigation()
        referContentCall()
    }
 @IBAction func   leftmenuBtnTapped(_ sender:UIButton){
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func referFreindBtnTapped(_ sender:UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferFriendPopUpVC") as? ReferFriendPopUpVC{
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
       }
}
extension ReferFriendVC:referDelegate{
    func refercenceUpdated(_ referCount: Int) {
       referContentCall()
    }
}
extension ReferFriendVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
         titleLbl.text = "Refer A Friend"
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
      //  rightMenuBtn.addTarget(self, action: #selector(callBtnTapped), for: .touchUpInside)
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
extension ReferFriendVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.referArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView, indexPath)
    }
   
    func configureCell(_ table:UITableView, _ index:IndexPath)->ReferListCell{
        let cell = table.dequeueReusableCell(withIdentifier: "ReferListCell") as! ReferListCell
        cell.configure(self.referArray[index.row])
        cell.card.cardViewWithCornerRadius(10)
        return cell
    }
}

extension ReferFriendVC {
private func referContentCall() {
    guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg: AlertMsg.InternectDisconnectError)
        return
    }
    let model  = UserModel.getObject()
    let  params = ["app_agent_id":model.agentId,"user_id":model.id] as [String : Any]
   
    ActivityView.show()
    WebServiceManager.instance.referFriendContent(params: params) { (status, json) in
        switch status {
        case StatusCode.Success:
            if let code = json["Code"] as? Int,code ==  200 {
              if  let payLoad = json["Payload"] as? [String:Any]{
                    if let content = payLoad["referred_content"] as? String {
                        self.referLabel.text = content
                        let height = content.height(constraintedWidth: self.view.frame.size.width-50, font: UIFont.systemFont(ofSize: 17), text:content )
                        self.contentHeight.constant = height
                    }
                if let count = payLoad["max_referred_count"] as? Int {
                    self.maxReferCount = count
                }
                
                if let refArray = payLoad["referred_list"] as? [[String:Any]],refArray.isEmpty == false  {
                    self.referArray.removeAll()
                    self.table.reloadData()
                    refArray.forEach { (dict) in
                        let sModel = ReferStudentModel(with: dict)
                        self.referArray.append(sModel)
                    }
                    self.referCount = self.referArray.count
                    if self.maxReferCount != 0 &&  self.referCount  >= self.maxReferCount {
                        self.referFreindBtn.isHidden = true
                    }else{
                       self.referFreindBtn.isHidden = false
                    }
                    self.table.reloadData()
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
