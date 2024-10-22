//
//  DegreePopUpVC.swift
//  Unica
//
//  Created by Mohit Kumar  on 20/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit

class DegreePopUpVC: UIViewController {
   var degreeList = [DegreeModel]()
    var delegate:eventDelegate? = nil
    @IBOutlet var supportView: UIView!
    @IBOutlet weak var table:UITableView!
    
    var selectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
     configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configure(){
            self.table.delegate = self
             self.table.dataSource = self
             self.supportView.cornerRadius(10)
               if AppSession.share.degreeList.isEmpty {
                 self.getDegreeList()
               }else{
                 self.degreeList = AppSession.share.degreeList
                   self.table.reloadData()
               }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.remove()
    }
   
}



extension DegreePopUpVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return degreeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            
            tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = degreeList[indexPath.row].name
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSelectedDegree(model:degreeList[indexPath.row])
        self.remove()
    }
}




extension DegreePopUpVC {
    func getDegreeList(){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        ActivityView.show()
        let model = UserModel.getObject()
        let param = ["user_id":model.id, "app_agent_id": model.agentId]
        WebServiceManager.instance.studentGetHighestLevelWithDetails(params: param) { (status, json) in
            ActivityView.hide()
            switch status {
            case 200:
                if let code = json["Code"] as? Int, code == 200  {
                    if let dict = json["Payload"] as? [String:Any],let degreeArray = dict["educations"] as? [[String:Any]],degreeArray.isEmpty == false   {
                        degreeArray.forEach { (degreeDict) in
                            let model = DegreeModel(with: degreeDict)
                            self.degreeList.append(model)
                        }
                        AppSession.share.degreeList = self.degreeList
                        self.table.reloadData()
                    }else{
                    if let msg = json["Message"] as? String {
                    self.showAlertMsg(msg:msg)
                    }
                    }
            }else{
                if let msg = json["Message"] as? String {
                self.showAlertMsg(msg:msg)
                }
                }
            default : ActivityView.hide()
                if let msg = json["Message"] as? String {
                self.showAlertMsg(msg:msg)
                }
            }
        }
    }
}
