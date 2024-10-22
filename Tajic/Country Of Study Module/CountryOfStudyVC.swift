//
//  CountryOfStudyVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CountryOfStudyVC: UIViewController  {
    @IBOutlet weak var table:UITableView!
    var countryList = [CountryModel]()
    var pageTitle = ""
    
    var isFetchingNextPage = true
    var pagingCounter = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        setupNavigation()
        DispatchQueue.main.async {
            self.getCountryList(self.pagingCounter)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func leftmenuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
  @IBAction func  callBtnTapped(_ sender:UIButton){
     
  }
}

extension CountryOfStudyVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 180, height: 45))
        titleLbl.text = pageTitle
        if pageTitle.isEmpty {
         titleLbl.text = "Countries of Study"
        }
         
        titleLbl.textColor = UIColor.white
        titleLbl.font = .systemFont(ofSize: 18)
        leftView.addSubview(titleLbl)
        let rightView = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 45))
        let chatBtn                                        = UIButton(type: .custom)
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
       // rightView.addSubview(unreadLabl)
        let rightBarBtn                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = rightBarBtn
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}
extension CountryOfStudyVC:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard countryList.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.countryList.count-2 }
        if needsFetch && isFetchingNextPage {
            self.getCountryList(self.pagingCounter)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCountryOfStudyCell(tableView, index: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        redirectToDetais(countryList[indexPath.row])
    }
    func redirectToDetais(_ model:CountryModel){
        if  model.url.isEmpty == false && model.url.isValidURL == true {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
             vc.titleString = model.name
             vc.urlString = model.url
                self.navigationController?.pushViewController(vc, animated: true)
             }
        }
    }
}
extension CountryOfStudyVC {
    func configureCountryOfStudyCell(_ table: UITableView, index: IndexPath)-> CountryOfStudyCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CountryOfStudyCell") as! CountryOfStudyCell
        cell.configure(countryList[index.row])
        return cell
    }
}

extension CountryOfStudyVC {
    private func getCountryList(_ index:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
    let model  = UserModel.getObject()
        let params  = ["app_agent_id":model.agentId,"user_id":model.id,"page_number":index] as [String : Any]
        
        ActivityView.show()
        WebServiceManager.instance.studentGetCountryOfStudyWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let data = json["Payload"] as? [String:Any]{
                    if let menuArray = data["countries"] as? [[String:Any]],menuArray.isEmpty == false   {
                        menuArray.forEach({ (menuDict) in
                            let model = CountryModel(with: menuDict)
                            self.countryList.append(model)
                        })
                        
                        self.pagingCounter += 1
                        self.isFetchingNextPage = true
                        self.table.reloadData()
                        self.getCountryList(self.pagingCounter)
                    }else{
                       self.pagingCounter = 1
                       self.isFetchingNextPage = false
                        self.table.reloadData()
                    }
                }
                else{
                    self.table.reloadData()
                    self.pagingCounter = 1
                    self.isFetchingNextPage = false
                    if let code = json["Code"] as? Int,code == 200  {
                        return
                    }
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
