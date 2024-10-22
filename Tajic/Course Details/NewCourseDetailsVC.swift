//
//  NewCourseDetailsVC.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 19/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class NewCourseDetailsVC: UIViewController {
    @IBOutlet var gradintView: GradientView!
  //  @IBOutlet weak var card: UIView!
    @IBOutlet weak var table: UITableView!
    var model = CourseDetailsModel()
    var courseId = ""
    var isProfileCourse = false
    var isFormFeature   = false
    @IBOutlet weak var noLbl: UILabel!
    
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
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
       // table.rowHeight = 200
       // table.estimatedRowHeight = UITableView.automaticDimension
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
extension NewCourseDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return   courseDetailsUpparCell(indexPath, tableView)
        case 1: return  configureInitalCell(indexPath, tableView)
        case 2: return  configurelanguageCell(indexPath, tableView)
         
        case 3: return configureIntakeCell(indexPath, tableView)
            
        case 4: return  descritpionCell(indexPath, tableView)
        case 5: return configureTimelineCell(indexPath, tableView)
            
        case 6: return  configureEligibilityCell(indexPath, tableView)
        case 7: return configureSpecialInstructionCell(indexPath, tableView)
            
        case 8: return  configureOtherRequirementCell(indexPath, tableView)
        case 9: return  configureJobOppertunityCell(indexPath, tableView)
        case 10: return  configurePSWOpportunityCell(indexPath, tableView)
        case 11: return  configureAccreditationCell(indexPath, tableView)
        case 12: return  configureCampusInfoCell(indexPath, tableView)
        case 13: return  configureVideoCell(indexPath, tableView)
       
        default: return descritpionCell(indexPath, tableView)
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2: if self.model.languageRequirementArray.isEmpty {return 0 }
        return CGFloat((self.model.languageRequirementArray.count * 30 ) + 60)
            
        case 3:if self.model.courseIntakeArray.isEmpty { return 0 }
        return CGFloat((self.model.courseIntakeArray.count * 40 ) + 50)
            
        case 4: if self.model.desc.isEmpty {return 0}
            return UITableView.automaticDimension
            
         case 5:    if self.model.timeLineArray.isEmpty {return 0}
            return CGFloat((self.model.timeLineArray.count * 50 ) + 60)
            
            
            
        case 6:if self.model.eligibility.isEmpty {return 0}
        return UITableView.automaticDimension
        case 7:if self.model.specialInstructions.isEmpty {return 0}
        return UITableView.automaticDimension
            
        case 8: if self.model.otherRequirements.isEmpty {return 0}
                return UITableView.automaticDimension
        case 9: if self.model.jobOpportunityPotential.isEmpty {return 0}
                return  UITableView.automaticDimension
       case 10: if self.model.pswpportunity.isEmpty {  return 0 }
                return  UITableView.automaticDimension
       case 11: if self.model.accreditationArray.isEmpty {  return 0 }
            return  180
        case 12: if self.model.campusListArray.isEmpty { return 0 }
            return CGFloat((self.model.campusListArray.count * 50 ) + 60)
        case 13:if self.model.videoArray.isEmpty { return 0 }
           // return 390
       return 0
        default:return UITableView.automaticDimension
        }
       
    }
    

    }
//***********************************************//
// MARK: UItable cell object
//***********************************************//
extension NewCourseDetailsVC{
    private func courseDetailsUpparCell(_ index:IndexPath,_ table:UITableView) -> CourseDetailsUpparCell {
        let cell = table.dequeueReusableCell(withIdentifier: "courseUpparCell") as! CourseDetailsUpparCell
        cell.isProfileCourse = isProfileCourse
        cell.isFormFeature   = isFormFeature
        cell.configure(model: model)
        cell.courseId = self.courseId
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    
    private func configureInitalCell(_ indexPath:IndexPath,_ table:UITableView) -> CourseDetailsInitialCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CourseDetailsInitialCell") as! CourseDetailsInitialCell
        cell.selectionStyle = .none
        cell.configure(self.model)
        cell.layoutIfNeeded()
        cell.setNeedsDisplay()
        return cell
    }
    
    private func configurelanguageCell(_ indexPath:IndexPath,_ table:UITableView) -> LanguageCell {
           let cell = table.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageCell
            cell.configure(self.model)
           cell.selectionStyle = .none
           cell.layoutIfNeeded()
           return cell
       }
    //IntakeCell
    
    private func configureIntakeCell(_ indexPath:IndexPath,_ table:UITableView) -> IntakeCell {
              let cell = table.dequeueReusableCell(withIdentifier: "IntakeCell") as! IntakeCell
               cell.configure(self.model)
              cell.selectionStyle = .none
              cell.layoutIfNeeded()
              return cell
          }
    
    
    
    
    private func descritpionCell(_ indexPath:IndexPath,_ table:UITableView) -> CourseLowerDescritpionCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CourseLowerDescritpionCell") as! CourseLowerDescritpionCell
         cell.configureCell(model: self.model)
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    
    //EligibilityCell
    
    private func configureEligibilityCell(_ indexPath:IndexPath,_ table:UITableView) -> EligibilityCell {
           let cell = table.dequeueReusableCell(withIdentifier: "EligibilityCell") as! EligibilityCell
            cell.configureCell(model: self.model)
           cell.selectionStyle = .none
           cell.layoutIfNeeded()
           return cell
       }
    
    //SpecialInstructionCell
    
    private func configureSpecialInstructionCell(_ indexPath:IndexPath,_ table:UITableView) -> SpecialInstructionCell {
              let cell = table.dequeueReusableCell(withIdentifier: "SpecialInstructionCell") as! SpecialInstructionCell
               cell.configureCell(model: self.model)
              cell.selectionStyle = .none
              cell.layoutIfNeeded()
              return cell
          }
    
    
    
    //JobOppertunityCell
    
    private func configureOtherRequirementCell(_ index:IndexPath,_ table:UITableView) -> OtherRequirementCell {
        let cell = table.dequeueReusableCell(withIdentifier: "OtherRequirementCell") as! OtherRequirementCell
        cell.selectionStyle = .none
        cell.configureCell(model: self.model)
        cell.layoutIfNeeded()
        return cell
    }
    
    
    
    
    private func configureJobOppertunityCell(_ index:IndexPath,_ table:UITableView) -> JobOppertunityCell {
        let cell = table.dequeueReusableCell(withIdentifier: "JobOppertunityCell") as! JobOppertunityCell
        cell.selectionStyle = .none
        cell.configureCell(model: self.model)
        cell.layoutIfNeeded()
        return cell
    }
    
    
    //// PSWOpportunityCell
    
    private func configurePSWOpportunityCell(_ index:IndexPath,_ table:UITableView) -> PSWOpportunityCell {
           let cell = table.dequeueReusableCell(withIdentifier: "PSWOpportunityCell") as! PSWOpportunityCell
           cell.selectionStyle = .none
           cell.configureCell(model: self.model)
           cell.layoutIfNeeded()
           return cell
       }
    
    
    //AccreditationCell
    
    
    private func configureAccreditationCell(_ index:IndexPath,_ table:UITableView) -> AccreditationCell {
              let cell = table.dequeueReusableCell(withIdentifier: "AccreditationCell") as! AccreditationCell
            cell.selectionStyle = .none
        cell.configure(model: self.model)
        
            cell.layoutIfNeeded()
        print(cell.frame)
              return cell
          }
    
        
    
    //CampusInfoCell
    
    
    
    private func configureCampusInfoCell(_ index:IndexPath,_ table:UITableView) -> CampusInfoCell {
                let cell = table.dequeueReusableCell(withIdentifier: "CampusInfoCell") as! CampusInfoCell
              cell.selectionStyle = .none
              cell.configure()
              cell.layoutIfNeeded()
                return cell
            }
    
    
    private func configureVideoCell(_ index:IndexPath,_ table:UITableView) -> VideoCell {
        let cell = table.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.selectionStyle = .none
        cell.configrueForCourseVideo(self.model)
        cell.layoutIfNeeded()
        return cell
             }
    
    
    /// TimelineCell
    
    
    
    
    private func configureTimelineCell(_ indexPath:IndexPath,_ table:UITableView) -> TimelineCell {
           let cell = table.dequeueReusableCell(withIdentifier: "TimelineCell") as! TimelineCell
        cell.configureCell(model: self.model)
        
           cell.selectionStyle = .none
           cell.layoutIfNeeded()
           return cell
       }
    
    
    
    
    //***********************************************//
    // MARK: Old Cells
    //***********************************************//
    
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



extension NewCourseDetailsVC {
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
                self.noLbl.text = ""
              if let code = json["Code"] as? Int, code != 200  {
                ActivityView.hide()
              if let msg = json["Message"] as? String {
                self.noLbl.text = msg
                }
                        return
                               }
                
                if let data = json["Payload"] as? [String:Any]{
                    let model = CourseDetailsModel(with: data)
                    self.model = model
                    self.table.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                        self.table.isHidden = false
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

extension NewCourseDetailsVC {
    func getFeatureCourses(courseId:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        //"user_type":model.userType,
        let params = ["user_id": model.id
            ,"course_id":courseId,"app_agent_id":model.agentId]
        ActivityView.show()
        WebServiceManager.instance.getFeatureCourseDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                self.noLbl.text = ""
                if let code = json["Code"] as? Int, code != 200  {
                    ActivityView.hide()
                    if let msg = json["Message"] as? String {
                      self.noLbl.text = msg
                    }
                  return
                }
                
                
                if let data = json["Payload"] as? [String:Any]{
                    let model = CourseDetailsModel(with: data)
                    self.model = model
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                        self.table.reloadData()
                        self.table.isHidden = false
                        
                        self.table.setNeedsLayout()
                        self.table.layoutIfNeeded()
                        self.table.reloadData()
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

