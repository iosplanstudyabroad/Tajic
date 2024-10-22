//
//  CountryFilterSelectionVC.swift
//  Aliff
//
//  Created by Mohit Kumar  on 24/07/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit


protocol  countryFilterProtocol {
    func getSelectedCountry(_ model:CountryModel)
}
class CountryFilterSelectionVC: UIViewController {
    @IBOutlet var card: UIView!
    @IBOutlet var menuTitle: UILabel!
    @IBOutlet weak var table:UITableView!
    @IBOutlet var cardHeight: NSLayoutConstraint!
    var delegate:countryFilterProtocol?  = nil
    var menuArray                = [CountryModel]()
    var isPerfectMatch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        self.card.cardViewWithCornerRadius(10)
        self.menuTitle.text  = "Select Country"
        self.getFilterCountryList()
        
    }

    @IBAction func closeBtnTapped(_ sender: UIButton) {self.remove()}
}

extension CountryFilterSelectionVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView, index: indexPath)
    }
    
    func configureCell(_ table:UITableView, index:IndexPath)-> CountryFilterCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CountryFilterCell") as! CountryFilterCell
        cell.configure(menuArray[index.row])
        cell.layoutIfNeeded()
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSelectedCountry(self.menuArray[indexPath.row])
        self.remove()
    }
}

extension CountryFilterSelectionVC {
    private func getFilterCountryList() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var  params = ["user_id":model.id,"app_agent_id":model.agentId] as [String : Any]
        
        if isPerfectMatch == false {
            params["crm_country"] = "Y"
        }else{
            params["for_unica_courses"] = "Y"
           // params["student_interested_country"] = "Y"
        }
        WebServiceManager.instance.studentGetFilterCountryListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                    if let countryList = data["interested_countries"] as? [[String:Any]],countryList.isEmpty == false  {
                        countryList.forEach { (dict) in
                            let model = CountryModel(with: dict)
                            self.menuArray.append(model)
                        }
                        AppSession.share.filterCountryList = self.menuArray
                        self.cardHeight.constant = CGFloat((self.menuArray.count+1) * 42)
                        if self.cardHeight.constant >= self.view.frame.size.height {
                            self.cardHeight.constant = self.view.frame.size.height - 100
                        }
                         self.table.reloadData()
                    }else{
                         self.table.reloadData()
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

