//
//  EventPopUPVC.swift
//  Unica
//
//  Created by Mohit Kumar  on 18/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit

protocol eventDelegate {
    func getSelectedGender(model:eventModel)
    func getSelectedYear(model:eventModel)
         func getSelectedBudget(model:eventModel)
        func getCourseType(model:eventModel)
func getSelectedDegree(model:DegreeModel)
    
}
class EventPopUPVC: UIViewController {
var eventList = [eventModel]()
var delegate:eventDelegate? = nil
    
    @IBOutlet var supportView: UIView!
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet var popUpTitle: UILabel!
    
    var selectedIndex = -1
    var viewType  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.supportView.cornerRadius(10)
       configure()
    }
    
    func configure(){
        if self.isEditing {
            if viewType == "Course Type" {
            popUpTitle.text = "Select Course Type"
                 self.eventList = AppSession.share.courseTypeList
                self.table.reloadData()
                if AppSession.share.courseTypeList.isEmpty {
                    getCourseAndYearList(isYear: false)
                }
            }else if viewType == "Gender" {
                popUpTitle.text = "Select Gender"
                let maleModel = eventModel(with: ["id" : "1","name":"Male"])
                self.eventList.append(maleModel)
                let feMaleModel = eventModel(with: ["id" : "2","name":"Female"])
                self.eventList.append(feMaleModel)
                self.table.reloadData()
            }
                
                
                else{
                    popUpTitle.text = "Select Budget"
                self.eventList = AppSession.share.budgetList
                self.table.reloadData()
                if AppSession.share.budgetList.isEmpty {
                 getBudgetList()
                }
            }
        }else{
            popUpTitle.text = "Select Year"
            self.eventList = AppSession.share.yearList
                          self.table.reloadData()
                          if AppSession.share.yearList.isEmpty {
                            getCourseAndYearList(isYear: true)
                          }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
         
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.remove()
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {}
}

extension EventPopUPVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            
            tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.numberOfLines = 0
        if self.isEditing == false {
           cell.textLabel?.text = eventList[indexPath.row].id
        }else{
          cell.textLabel?.text = eventList[indexPath.row].eventName
        }
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isEditing {
            if viewType == "Course Type" {
              delegate?.getCourseType(model:eventList[indexPath.row])
            } else if viewType == "Gender" {
                delegate?.getSelectedGender(model:eventList[indexPath.row] )
            }
            else{
              delegate?.getSelectedBudget(model:eventList[indexPath.row])
            }
        }else{
          delegate?.getSelectedYear(model:eventList[indexPath.row])
        }
        self.remove()
    }
}

extension EventPopUPVC {
     func getEventList() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
            ActivityView.show()
        
        let model = UserModel.getObject()
        
            let params            = ["app_agent_id":model.agentId,"user_type":"S"]
           // let url = kAPIBaseURL + "student-event-list.php"
        
        
        WebServiceManager.instance.studentEventListWithDetails(params:params) { (code, json) in
            switch code {
            case 200: if let result = json["Code"] as? Int,result ==   200 {
                if let data = json["Payload"] as? [String:Any] {
                    if let eventArray = data["events"] as? [[String:Any]],eventArray.isEmpty == false {
                        eventArray.forEach { (eventDict) in
                            let model = eventModel(with: eventDict)
                            self.eventList.append(model)
                        }
                       // AppSession.share.eventList = self.eventList
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            guard self.table != nil else {return}
                            self.table.reloadData()
                        }
                    }
                    print(data)
                }
            }else{
                if let msg = json["Message"] as? String {
                    self.showAlertMsg(msg: msg)
                }
                
            }
                                
                ActivityView.hide()
            default:break
            }
        }
        
    
        }
    
    
    func getBudgetList() {
        guard StaticHelper.isInternetConnected else {
                  showAlertMsg(msg: AlertMsg.InternectDisconnectError)
                  return
              }
        ActivityView.show()
        let model = UserModel.getObject()
        let params  = ["user_id":model.id,"app_agent_id":model.agentId,]
        WebServiceManager.instance.studentGetBudgetPreferenceWithDetails(params:params) { (code, json) in
            switch code {
            case 200: if let result = json["Code"] as? Int,result ==   200 {
                if let data = json["Payload"] as? [String:Any] {
                    if let eventArray = data["budget"] as? [[String:Any]],eventArray.isEmpty == false {
                        eventArray.forEach { (eventDict) in
                            let model = eventModel(with: eventDict)
                            self.eventList.append(model)
                        }
                        AppSession.share.budgetList = self.eventList
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                        guard self.table != nil else {return}
                         self.table.reloadData()
                        }
                    }
                    print(data)
                }
            }else{
                if let msg = json["Message"] as? String {
                    self.showAlertMsg(msg: msg)
                }
                
            }
            ActivityView.hide()
            default: ActivityView.hide()
                break
            }
        }
        }
    private func getCourseAndYearList(isYear:Bool){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        ActivityView.show()
        let model = UserModel.getObject()
        var agentId = ""
        if model.agentId.isEmpty {
               agentId = AppSession.share.agentId
           }else{
             agentId = model.agentId
           }
        
        
        let params = ["user_id":model.id,"app_agent_id":agentId]
        WebServiceManager.instance.getYearAndCourseType(params: params) { (status, json) in
            switch status {
            case 200: if let code = json["Code"] as? Int, code == 200 {
                if let dict = json["Payload"] as? [String:Any] {
                    if isYear {
                        if  let typeArray = dict["admission_years"] as? [[String:Any]],typeArray.isEmpty == false{
                        
                        typeArray.forEach { (data) in
                            let model = eventModel(with: data)
                            self.eventList.append(model)
                        }
                           
                         AppSession.share.yearList = self.eventList
                        }
                    }else{
                        if  let typeArray = dict["courses_type"] as? [[String:Any]],typeArray.isEmpty == false{
                         
                         typeArray.forEach { (data) in
                             let model = eventModel(with: data)
                             self.eventList.append(model)
                         }
                            
                          AppSession.share.courseTypeList = self.eventList
                         }
                    }
          
                     DispatchQueue.main.asyncAfter(deadline: .now()) {
                                           guard self.table != nil else {return}
                                            self.table.reloadData()
                                           }
                }
            }else{
            if let msg = json["Message"] as? String {
                self.showAlertMsg(msg: msg)
                }
            }
                
            ActivityView.hide()
            default:
                ActivityView.hide()
                if let msg = json["Message"] as? String {
                self.showAlertMsg(msg: msg)
                }
            }
        }
    }
    /*
    private func getCourseTypeList() {
            let params:NSMutableDictionary  = NSMutableDictionary()
            let url = kAPIBaseURL + "courses-type.php"
        
        
        
        
        ConnectionManager.sharedInstance()?.sendGETRequest(forURL: url, params:params, timeoutInterval: 30, showSystemError: true, completion: { (json, error) in
            if error == nil {
                if let code = json?["Code"] as? Int {
                    switch code {
                    case 200:
                        if let data = json?["Payload"] as? [String:Any] {
                            if let eventArray = data[kCourses_type] as? [[String:Any]],eventArray.isEmpty == false {
                                eventArray.forEach { (eventDict) in
                                    let model = eventModel(with: eventDict)
                                    self.eventList.append(model)
                                }
                                AppSession.share.courseTypeList = self.eventList
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                 self.table.reloadData()
                                }
                            }
                            print(data)
                        }else{
                        }
                    case 404:break
                    default:break
                    }
                }
            }
        })
        }
    
    */
}




