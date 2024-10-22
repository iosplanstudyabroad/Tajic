//
//  CountryListVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 12/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

protocol countryDelegate {
    func getSelectedCountry(model:CountryModel)
    func getCountryForStudy(model:CountryModel)
}
class CountryListVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    
    var countryList = [CountryModel]()
    var delegate:countryDelegate? = nil
    var filterArray = [CountryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        if  AppSession.share.countryPopUpList.isEmpty == false {
            self.countryList = AppSession.share.countryPopUpList
            self.filterArray = countryList
            self.table.reloadData()
            return
        }
        getCountryList()
    }
    
    @IBAction func closeBtnTapped(_ sender:UIButton){
        self.remove()
    }
    
    func searchKeyWord(_ keyword:String){
       filterArray = self.countryList.filter{(x) -> Bool in
            (x.name.lowercased().range(of: keyword.lowercased()) != nil)
        }
       self.table.reloadData()
    }
}

extension CountryListVC:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result                             = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if result.count > 2 {
           searchKeyWord(result)
        }else{
            self.filterArray = self.countryList
            self.table.reloadData()
        }
        print(result)
      
      return true
    }
    
    
}

extension CountryListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func configureCell(_ table: UITableView,_ index: IndexPath)-> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CountryCell")!
        cell.layoutIfNeeded()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode  = .byWordWrapping
        cell.textLabel?.text = filterArray[index.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing {
            delegate?.getCountryForStudy(model:filterArray[indexPath.row])
           self.remove()
            return
        }
        delegate?.getSelectedCountry(model:filterArray[indexPath.row])
        self.remove()
    }
}

extension CountryListVC {
func getCountryList(){
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
    let param = ["user_id":model.id,"app_agent_id":agentId]
    WebServiceManager.instance.studentSearchCountryWithDetails(params: param) { (status, json) in
        ActivityView.hide()
        switch status {
        case 200:
            if let code = json["Code"] as? Int, code == 200  {
                if let dict = json["Payload"] as? [String:Any],let countryArray = dict["countries"] as? [[String:Any]],countryArray.isEmpty == false   {
                    countryArray.forEach { (countryDict) in
                        let model = CountryModel(with: countryDict)
                        self.countryList.append(model)
                    }
                    self.filterArray = self.countryList
                    AppSession.share.countryPopUpList = self.countryList
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
