//
//  CourseDetailsVC.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseDetailsVC: UIViewController {
    @IBOutlet var gradintView: GradientView!
  //  @IBOutlet weak var card: UIView!
    @IBOutlet weak var table: UITableView!
    var model = CourseDetailsModel()
    var courseId = ""
    var isProfileCourse = false
    var isFormFeature   = false
    @IBOutlet weak var firtIntakeLbl: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    
    func configure(){
        gradintView.setGradientColor()
        addLeftMenuBtnOnNavigation()
        if isFormFeature {
                   getFeatureCourses(courseId:courseId)
               }else{
                  getCourses(courseId:courseId)
               }
       table.cardView()
        table.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let backBtn                           = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        //add function for button
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        backBtn.frame                         = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(backBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 200, height: 45))
        titleLbl.text = "Course Details"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn                            = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//***********************************************//
// MARK: UITable View Delegte Methods
//***********************************************//
extension CourseDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return courseDetailsUpparCell(indexPath:indexPath, tableView: tableView)
        case 1: return courseDetailsLowerCell(indexPath:indexPath, tableView: tableView)
        default:return courseDetailsTimeLineCell(indexPath:indexPath, tableView: tableView)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return UITableView.automaticDimension
//        case 0: if model.interested.isEmpty {
//         return 310
//        }
          
        case 1: if model.desc.count > 0 {
            return 330 + model.desc.height(constraintedWidth: self.view.frame.size.width-20, font:  UIFont.systemFont(ofSize: 17.5), text: model.desc.htmlToString) + calculateHeigt()
        }else {return 330}
        case 2:  let height = model.timeLineArray.count*52
        return CGFloat(320+height)
        default: return 0
            }
        }
    
    func calculateHeigt()-> CGFloat{
        let height =    57 + model.courseIntakeArray.count*52
        return  CGFloat(height)
    }
    }


func height(constraintedWidth width: CGFloat, font: UIFont,text:String) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = text
    label.font = font
    label.sizeToFit()
    return label.frame.height
}

//***********************************************//
// MARK: UItable cell object
//***********************************************//
extension CourseDetailsVC{
    private func courseDetailsUpparCell(indexPath:IndexPath,tableView:UITableView) -> CourseDetailsUpparCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseUpparCell") as! CourseDetailsUpparCell
        cell.isProfileCourse = isProfileCourse
        cell.configure(model: model)
        cell.courseId = self.courseId
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    private func courseDetailsLowerCell(indexPath:IndexPath,tableView:UITableView) -> CourseDetailsLowerCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsLowerCell") as! CourseDetailsLowerCell
        cell.selectionStyle = .none
        cell.configureCell(model: self.model)
        cell.layoutIfNeeded()
        return cell
    }
    private func courseDetailsTimeLineCell(indexPath:IndexPath,tableView:UITableView) -> CourseDetailsTimeLineCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsTimeLineCell") as! CourseDetailsTimeLineCell
        cell.selectionStyle = .none
        cell.configureCell(model: self.model)
        cell.layoutIfNeeded()
        return cell
    }
    @IBAction func fevtBtnTapped(_ sender: UIButton) {}
    @IBAction func selectBtnTapped(_ sender: UIButton) {}
}



extension CourseDetailsVC {
    func getCourses(courseId:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":courseId]
        ActivityView.show()
        WebServiceManager.instance.studentGetCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                    let model = CourseDetailsModel(with: data)
                    self.model = model
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                        self.table.reloadData()
                        self.table.isHidden = false
                    })
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

extension CourseDetailsVC {
    func getFeatureCourses(courseId:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params = ["user_id": model.id
            ,"user_type":model.userType,"course_id":courseId,"app_agent_id":model.agentId]
        ActivityView.show()
        WebServiceManager.instance.getFeatureCourseDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                    let model = CourseDetailsModel(with: data)
                    self.model = model
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                        self.table.reloadData()
                        self.table.isHidden = false
                    })
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
