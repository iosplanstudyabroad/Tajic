//
//  LatestEventsVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class LatestEventsVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var noLable:UILabel!
    var eventList = [LatestEventModel]()
     var backGroundColorArray = ["#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23","#f05424","#009a4b","#0344ab","#fcad23"]
    
    var pageTitile = ""
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
        self.view.isHidden = false
         getevents()
    }
    
    @IBAction func leftmenuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
  @IBAction func  callBtnTapped(_ sender:UIButton){
  }
}

extension LatestEventsVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = pageTitile
        if pageTitile.isEmpty {
         titleLbl.text = "Latest Events"
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
extension LatestEventsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureEventCell(tableView, index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.view.isHidden = true
          self.moveToEventDetailsVC(self.eventList[indexPath.row])
        }
    }
    
    func moveToEventDetailsVC(_ event:LatestEventModel){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsVC")  as? EventDetailsVC {
            vc.currentEvent = event
            self.navigationController?.pushViewController(vc, animated: true)
    }
    }
}
extension LatestEventsVC {
    func configureEventCell(_ table: UITableView, index: IndexPath)-> EventCell {
        let cell = table.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        cell.layoutIfNeeded()
        cell.configure(eventList[index.row])
        cell.interestBtn.tag = index.row
        //cell.setColor(hex: backGroundColorArray[index.row])
        cell.interestBtn.addTarget(self, action: #selector(interetsBtnTapped), for: .touchUpInside)
        return cell
    }
    @objc func interetsBtnTapped(_ sender:UIButton){
        if eventList[sender.tag].isRegistered {
         showAlertMsg(msg: "Already Registered")
        }
        let model = eventList[sender.tag]
        showConfirmationAlert(model.eventId)
    }
    
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
extension LatestEventsVC {
  private func getevents() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
         let model = UserModel.getObject()
    let  params = ["app_agent_id":model.agentId,"userid":model.id]
        self.noLable.text = ""
        ActivityView.show()
        WebServiceManager.instance.studentGetEventIistWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                self.noLable.text = ""
                if let data = json["Payload"] as? [String:Any]{
                    if let eventsArray = data["events"] as? [[String:Any]],eventsArray.isEmpty == false  {
                        self.eventList.removeAll()
                        self.table.reloadData()
                        eventsArray.forEach({ (menuDict) in
                            let model = LatestEventModel(with: menuDict)
                           self.eventList.append(model)
                        })
                       self.table.reloadData()
                    }
                    else{
                        if let msg = json["Message"] as? String {
                         self.noLable.text = msg
                        }
                    }
                }
                else{
                    if let msg = json["Message"] as? String {
                     self.noLable.text = msg
                    }
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

extension LatestEventsVC {
    private func registerInevent(_ eventId:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model  = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"event_id":eventId,"user_id":model.id]
        
        ActivityView.show()
        WebServiceManager.instance.registerForeventWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let code = json["Code"] as? Int, code == 200  {
                    ActivityView.hide()
                    if let msg = json["Message"] as? String {
                        self.alertWithAction(msg: msg)
                    }
                    return
                }else{
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
extension LatestEventsVC {
 func alertWithAction(msg: String) {
   let alert = UIAlertController(title: "", message: msg
    , preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "OK", style: .default) { (action) in
        self.getevents()
    }
    alert.addAction(okayAction)
    self.present(alert, animated: true, completion: nil)
    }
}
