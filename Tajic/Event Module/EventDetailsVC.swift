//
//  EventDetailsVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 25/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var registerBtn:UIButton!
    var currentEvent:LatestEventModel!
    var bannerArray = [BannerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

    func configure(){
        bannerArray = currentEvent.bannerArray
        setupNavigation()
       registerButtonSetup()
         table.rowHeight =   UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.reloadData()
    }
    
    func registerButtonSetup(){
        if currentEvent.isRegistered {
                   registerBtn.setTitleColor(.black, for: .normal)
                   registerBtn.setTitle("Registered", for: .normal)
               }else{
                  registerBtn.setTitle("Register", for: .normal)
                   registerBtn.setTitleColor(.blue, for: .normal)
               }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func leftmenuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func interetsBtnTapped(_ sender:UIButton){
        if currentEvent.isRegistered {
         showAlertMsg(msg: "Already Registered")
            return
        }
        showConfirmationAlert(currentEvent.eventId)
    }
}

extension EventDetailsVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        
         titleLbl.text = "Event Details"
        
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
       // rightMenuBtn.addTarget(self, action: #selector(callBtnTapped), for: .touchUpInside)
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

extension EventDetailsVC {
    func showConfirmationAlert(_ eventId:String){
        let alert = UIAlertController(title: "", message: "Are you sure, You want to register for this event.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "YES", style: .default) { (action) in
            self.registerInevent(eventId)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension EventDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return configureBannerCell(tableView)
        default:return configureEventCell(tableView, indexPath)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return 200
        default:return UITableView.automaticDimension
        }
    }
    
}
extension EventDetailsVC {
    func configureEventCell(_ table:UITableView,_ index:IndexPath)-> EventDetailsCell {
        let cell = table.dequeueReusableCell(withIdentifier: "DetailsCell") as! EventDetailsCell
        cell.configure(self.currentEvent)
        cell.layoutIfNeeded()
        return cell
    }
    
    
    
    private func configureBannerCell(_ table: UITableView)->UNAgentBannerCell{
        let cell = table.dequeueReusableCell(withIdentifier: "AgentBannerCell") as! UNAgentBannerCell
        cell.configure(self.bannerArray)
        return cell
    }
    
    
}
extension EventDetailsVC {
    private func registerInevent(_ eventId:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
    let  params = ["app_agent_id":model.agentId,"event_id":eventId,"user_id":model.id]

        ActivityView.show()
        WebServiceManager.instance.registerForeventWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let code = json["Code"] as? Int, code == 200 {
                    ActivityView.hide()
                    self.currentEvent.isRegistered = true
                    self.registerButtonSetup()
                    if let msg = json["Message"] as? String {
                        self.showAlertMsg(msg: msg)
                    }
                    return
                }   else{
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

