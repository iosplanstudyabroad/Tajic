//
//  ReachUsVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import GoogleMaps
class ReachUsVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet var mapView: GMSMapView!
   
    @IBOutlet var ViewHeightConst: NSLayoutConstraint!
    
    var reachUsModel = ReachUsModel()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func configure(){
        self.table.rowHeight = 150
        self.table.estimatedRowHeight = UITableView.automaticDimension
        
        getAddressDetails()
        addLeftMenuBtnOnNavigation()
    }
    
    @IBAction func otherBranchBtnTapped(_ sender: Any) {
        showOtherBranchPopUP()
    }
    
}
extension ReachUsVC:BranchDelegate {
    func getSelectedBranch(index: Int) {
        self.selectedIndex = index
        self.table.reloadData()
         let models = self.reachUsModel.branchesList[selectedIndex]
        loadMap(models)
    }
    
    func showOtherBranchPopUP(){
         if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchListPopUpVC") as? BranchListPopUpVC {
             vc.delegate     = self
            vc.branchArray   = self.reachUsModel.branchesList
            vc.selectedIndex = self.selectedIndex
             if let window = UIApplication.shared.keyWindow {
                 window.rootViewController?.add(vc)
             }
         }
    }
}
extension ReachUsVC{
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-100, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: self.view.frame.size.width-110, height: 45))
        titleLbl.text = "Reach Us"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}
extension ReachUsVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return configureAgentCell(tableView,  indexPath)
        default:return configureAddressCell(tableView, indexPath)
        }
    }
}
extension ReachUsVC{
    func configureAddressCell(_ table: UITableView, _ index: IndexPath)->ReachUsAddressCell{
        let cell = table.dequeueReusableCell(withIdentifier: "ReachUsAddressCell") as!ReachUsAddressCell
        if self.reachUsModel.branchesList.isEmpty == false {
         cell.configure(self.reachUsModel.branchesList[selectedIndex])
        }
        cell.layoutIfNeeded()
        cell.card.cardView()
        cell.card.cornerRadius(10)
        return cell
    }
    func configureAgentCell(_ table: UITableView, _ index: IndexPath)-> ReachUsAgentCell{
        let cell = table.dequeueReusableCell(withIdentifier: "ReachUsAgentCell") as!ReachUsAgentCell
        cell.configure(self.reachUsModel.agentModel)
        cell.layoutIfNeeded()
        cell.card.cardView()
        cell.card.cornerRadius(10)
        return cell
    }
}
extension ReachUsVC {
    func loadMap(_ model:BranchModel){
       let latitude                       = model.latitude
      let longitude                       = model.longitude
      let position:CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
             
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
         mapView.camera = camera
         mapView.animate(to: camera)
        
        
        let marker: GMSMarker             = GMSMarker()
        marker.title                      = model.name
        marker.snippet                    = model.address
         let icon                      = UIImage(named: "location_icon")
        marker.icon = icon
        marker.appearAnimation           = .none
         marker.position = position
        DispatchQueue.main.async {
            marker.map = self.mapView
        }
    }
}
extension ReachUsVC {
    func getAddressDetails() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
         let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id": model.id]
        
        ActivityView.show()
        WebServiceManager.instance.studentGetReachUsListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                
                if let data = json["Payload"] as? [String:Any] {
                   let rModel = ReachUsModel(data)
                    self.reachUsModel = rModel
                    DispatchQueue.main.async {
                        self.table.reloadData()
                        self.table.layoutIfNeeded()
                        self.ViewHeightConst.constant = self.table.contentSize.height
                    }

                    if self.reachUsModel.branchesList.isEmpty == false {
                        if let models = self.reachUsModel.branchesList.first {
                           self.loadMap(models)
                        }
                    }
                }
                else{
                    if let msg = json["Message"] as? String {
                    self.showAlertMsg(msg:msg )
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
