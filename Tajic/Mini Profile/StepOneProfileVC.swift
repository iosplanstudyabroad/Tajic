//
//  StepOneProfileVC.swift
//  CampusFrance
//
//  Created by UNICA on 22/05/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class StepOneProfileVC: UIViewController {
    var refreshControl = UIRefreshControl()
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var stepCounter: StepIndicatorView!
    @IBOutlet weak var bottomView: GradientView!
    @IBOutlet weak var tableView: UITableView!
    var courseArray    = [CourseModel]()
    var gradeMenuArray = [GradeModel]()
    var isCompleted    = ""
    var subMenuHeight  = 0
    var gradingSection = -1
    var stepOneMod     = StepOneModel()
    var selectionString = "NotYet"
    var selectedGradeId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        configurations()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.isHidden   = true
        let model            = UserModel.getObject()
        if model.profileCompleted == "Y"{
            getProfile()
        }
        getEducationLevel()
        stepOneMod.coutryId = 102
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func  configurations() {
        AppSession.share.miniProfileModel =  MiniProfileModel()
        stepCounter.configureStep()
       // gradientView.setGradientColor()
        addLeftMenuBtnOnNavigation()
        pullToRefresh()
    }
    
    func pullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        getEducationLevel()
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let backBtn                                             = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        //add function for button
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        //set frame
        backBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(backBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = "Step - 1"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if validations() {
            if   let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepThreeProfileVC") as? StepThreeProfileVC {
                vc.courseArray = courseArray
                vc.stepOneMod = stepOneMod
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//***********************************************//
// MARK: UITable view methods
//***********************************************//
extension StepOneProfileVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Number :- \(section)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        case 3: switch selectedGradeId {
        case -1,3,4,5,6: return 0
        default:return 1
            }
        default: switch stepOneMod.highEducationId {
        case 1: return 4
        case 2,3: return 3
        case 4,5: return 2
        case -1,6,7,8,9 : return 1
        default : return 1
        }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0: switch indexPath.row {
                case 0: return self.completeOrOngoingCell()
                default: return self.instituteNameCell()
               }
        case 1: return self.highestLevelCell()
        case 2: return self.gradingSystemCell(indexPath:indexPath)
        case 3:return self.percentageCell()
        default:switch stepOneMod.highEducationId {
         case 1: switch indexPath.row {
         case 0: return self.postGraduationCell()
         case 1: return self.graduationCell()
         case 2: return self.highSchoolCell()
         default: return self.otherQualificationCell()
        }
        case 2,3: switch indexPath.row {
         case 0:  return self.graduationCell()
         case 1:  return self.highSchoolCell()
         default: return self.otherQualificationCell()
        }
        case 4,5: switch indexPath.row {
         case 0: return self.highSchoolCell()
         default: return self.otherQualificationCell()
        }
        case -1,6,7,8,9 : return self.otherQualificationCell()
        default :return self.otherQualificationCell()
        }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:switch indexPath.row {
        case 0: return 148
        default:return 180
            }
       case 1:switch indexPath.row {
            case 0:return CGFloat((self.courseArray.count*30)+146)
            default:return 303
                }
        case 2: return  CGFloat((self.gradeMenuArray.count*32)+subMenuHeight+20)
        case 3:return 103
        default: return 303
        }
    }
}
//***********************************************//
// MARK: UITabelview custom cells Section Zero
//***********************************************//
extension StepOneProfileVC{
    private func completeOrOngoingCell() -> CompleteOrOngoingCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteOrOngoingCell") as!CompleteOrOngoingCell
          cell.delegate = self
          cell.configureView()
          return cell
      }
      
      private func instituteNameCell() -> InstituteNameCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "InstituteNameCell") as!InstituteNameCell
         cell.delegate = self
          cell.configure(stepOneMod.instName)
          return cell
      }
}
//***********************************************//
// MARK:  UITabelview custom cells Section One
//***********************************************//
extension StepOneProfileVC{
      private func highestLevelCell() -> HighestLevelCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "HighestLevelCell") as! HighestLevelCell
          cell.configureView()
          cell.courseArray = courseArray
          cell.completedOrOnGoingTapped(isCompleted: isCompleted)
          cell.updateTable()
          cell.delegate = self
          return cell
      }
    
    private func highSchoolCell() -> HighSchoolCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighSchoolCell") as! HighSchoolCell
        cell.prefill()
        return cell
    }
    
    private func graduationCell() -> GraduationCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "GraduationCell") as! GraduationCell
            cell.prefill()
           return cell
       }
    private func postGraduationCell() -> PostGraduationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostGraduationCell") as! PostGraduationCell
        cell.prefill()
        return cell
    }
    private func otherQualificationCell() -> OtherQualificationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherQualificationCell") as! OtherQualificationCell
        cell.prefill()
        return cell
       }
}
//***********************************************//
// MARK:  UITabelview custom cells Section Two
//***********************************************//
extension StepOneProfileVC{
      private func gradingSystemCell(indexPath: IndexPath) -> GradingSystemCell {
          let cell               = tableView.dequeueReusableCell(withIdentifier: "GradingSystemCell") as! GradingSystemCell
          cell.delegagte         = self
          cell.openMenudelegagte = self
          cell.gradeMenuArray.removeAll()
          cell.reload()
          if gradeMenuArray.isEmpty == false {
              cell.gradeMenuArray = gradeMenuArray
              cell.selectedSection = gradingSection
              cell.reload()
          }
          return cell
      }
    
    private func percentageCell() -> PercentageCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PercentageCell") as! PercentageCell
        cell.prefill()
        return cell
    }
}
//***********************************************//
// MARK: Grading Protocol
//***********************************************//
extension StepOneProfileVC:gradeOpenMenuProtocol,InstituteNamePrtocol{
    func getEnteredText(text:String){
        stepOneMod.instName = text
    }
    func getTappedMenuModel(with model: GradeModel, selectedSection: Int) {
        print(model.courseId, model.courseName)
        if model.courseId.isEmpty == false {
          selectedGradeId = Int(model.courseId)!
            self.tableView.reloadSections([3], with: .none)
        }
        setHeightFromGradingSubMenu(height: model.subMenuHeight, section: selectedSection)
    }
    
    func setHeightFromGradingSubMenu(height:Int, section:Int){
        subMenuHeight = height
        gradingSection = section
        tableView.reloadRows(at: [IndexPath(row: 0, section:2)], with: .automatic)
    }
    func reloadIndex(indexPath: IndexPath) {
        let index = IndexPath(row: 2, section: 0)
        tableView.reloadRows(at: [index], with: .automatic)
    }
}

//***********************************************//
// MARK: Complete or on going cell data here
//***********************************************//
extension StepOneProfileVC:completeOnGoingProtocol{
    func onGoingTapped(isCompleted: String) {
        stepOneMod.isCompleted = "false"
        self.isCompleted                  = isCompleted
        tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        selectionString = "No"
    }
    
    func completedTapped(isCompleted:String){
        stepOneMod.isCompleted = "true"
        self.isCompleted                  = isCompleted
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        selectionString = "Yes"
    }
    func enterdCourseName(courseName: String) {
        print("CourseName \(courseName)")
        stepOneMod.highEducationName = courseName
    }
}

//***********************************************//
// MARK: Highest Level protocol
//***********************************************//
extension StepOneProfileVC:highestLevelProtocol {
    func getSelectedCourse(model: CourseModel) {
        stepOneMod.highEducationId = Int(model.courseId)!
        AppSession.share.miniProfileModel.firstStep.highEducationId = Int(model.courseId)!
        AppSession.share.miniProfileModel.postGraduationDetails = PostGraduationModel()
        AppSession.share.miniProfileModel.graduationDetails = GraduationModel()
        AppSession.share.miniProfileModel.highSchoolDetails = HighSchoolModel()
            AppSession.share.miniProfileModel.otherEducationDetails = OtherEudcationModel()
        print(model.courseName, model.courseId)
        
           
        
         self.tableView.reloadData()
    
    }
    func getSelectedCountryDetails(model: CountryModel) {
        stepOneMod.coutryId = Int(model.id)!
        AppSession.share.miniProfileModel.firstStep.coutryId = Int(model.id)!
    }
}

//***********************************************//
// MARK: Grading Protocol
//***********************************************//
extension StepOneProfileVC:gradingProtocol {
    func getGradeAndSubGrade(gradeModel:GradeModel,subGradeModel:GradeMenuModel){
        stepOneMod.gradeId = Int(gradeModel.courseId)!
        stepOneMod.subgradeId = Int(subGradeModel.gradeId)!
        AppSession.share.miniProfileModel.firstStep.gradeId = Int(gradeModel.courseId)!
        AppSession.share.miniProfileModel.firstStep.subgradeId = Int(subGradeModel.gradeId)!
        print(gradeModel.courseId, gradeModel.courseName)
    }
}

//***********************************************//
// MARK: Web services
//***********************************************//
extension StepOneProfileVC {
    func getProfile() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id":model.id,"user_type":"S"] as [String : Any]
        ActivityView.show()
        WebServiceManager.instance.studentGetMiniProfileStatusWithDetails(params: params) { [weak self](status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                    let model = MiniProfileModel(with: data)
                    AppSession.share.miniProfileModel = model
                    self?.stepOneMod =   AppSession.share.miniProfileModel.firstStep
                    if AppSession.share.miniProfileModel.firstStep.isCompleted == "true"{
                        self?.selectionString = "Yes"
                    }else{
                        self?.selectionString = "No"
                    }
                    print(model.firstStep.coutryId)
                    self?.tableView.reloadData()
                }
                else{
                    self?.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self?.getGrades()
                })
            case StatusCode.Fail:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    func getEducationLevel() {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id":model.id,"user_type":"S"] as [String : Any]
        ActivityView.show()
        WebServiceManager.instance.studentGetHighestLevelWithDetails(params: params) { [weak self](status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any], let courseArray = data["educations"] as? [[String:Any]]{
                    courseArray.forEach({ (dict) in
                        let model = CourseModel(With: dict)
                        self?.courseArray.append(model)
                    })
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                }
                else{
                    self?.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self?.getGrades()
                })
            case StatusCode.Fail:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    func  getGrades(){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        self.gradeMenuArray.removeAll()
        self.tableView.reloadData()
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id":model.id,"user_type":"S"] as [String : Any]
        ActivityView.show()
        WebServiceManager.instance.studentGetGradesWithDetails(params: params) { [weak self](status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [[String:Any]]{
                    self?.gradeMenuArray.removeAll()
                    data.forEach({ (dict) in
                        print(dict)
                        let model = GradeModel(With: dict)
                        self?.gradeMenuArray.append(model)
                    })
                    self?.tableView.reloadData()
                }
                else{
                    self?.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self?.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
}
extension StepOneProfileVC{
    func validations()-> Bool{
        if  selectionString == "NotYet" {
            showAlertMsg(msg: "Select your Highest level of  Education")
            return false
        }
        // Select level of study do you wish to apply for.
        if stepOneMod.highEducationName.isEmpty {
            showAlertMsg(msg: "Enter Course Name")
            return false
        }
        
        if stepOneMod.instName.isEmpty {
            showAlertMsg(msg: "Enter Institute and Award body name")
            return false
        }
        if stepOneMod.highEducationId == -1  {
            showAlertMsg(msg: "Select your Highest level of  Education")
            return false
        }
        if stepOneMod.coutryId == -1 {
            showAlertMsg(msg: "Enter your country")
            return false
        }
        //***********************************************//
        // MARK: Education Details 
        //***********************************************//
        switch stepOneMod.highEducationId {
        case 1:
            if postGraduationValidation() == false {
                           return false
                       }
            if graduationValidation() == false {
                return false
            }
           
            if highSchoolValidation() == false {
                return false
            }
        case 2,3:
         if graduationValidation() == false {
            return false
       }
            if highSchoolValidation() == false {
             return false
            }
        case 4,5:if highSchoolValidation() == false {
         return false
        }
        default:break
        }
        
        if stepOneMod.highEducationId == 1 {
            if postGraduationValidation() == false {
                return false
            }
            if graduationValidation() == false {
                return false
            }
            if highSchoolValidation() == false {
                return false
            }
        }
        
        if stepOneMod.gradeId == -1 {
            showAlertMsg(msg: "Select your Grade Scores" )
            return false
        }
        switch stepOneMod.gradeId {
          case -1,3,4,5,6:print("")
          case 1,2,7,8,9,10,11,12,13: if  AppSession.share.miniProfileModel.firstStep.subgradePercentage.isEmpty {
          showAlertMsg(msg: "Please enter exact score.")
          return false
                  }
        default: break
              }
        
        if stepOneMod.subgradeId == -1 {
            showAlertMsg(msg: "Select your Grade Scores")
            return false
        }
        
        switch stepOneMod.gradeId {
        case -1,3,4,5,6:print("")
        case 1,2,7,8,9,10,11,12,13: if  AppSession.share.miniProfileModel.firstStep.subgradePercentage.isEmpty {
        showAlertMsg(msg: "Please enter exact score.")
        return false
                }
      default: break
            }
        
        return true
    }
    
    func highSchoolValidation()-> Bool{
        let high  = AppSession.share.miniProfileModel.highSchoolDetails
        if high.schoolName.isEmpty {
           showAlertMsg(msg: "Enter High School Name")
           return false
        }
        if high.subjectName.isEmpty {
           showAlertMsg(msg: "Enter High School Subject")
            return false
        }
        if high.awardingBody.isEmpty {
           showAlertMsg(msg: "Enter High School Awarding Body")
            return false
        }
        if high.passingYear.isEmpty {
           showAlertMsg(msg: "Enter High School year")
            return false
        }
        if high.marks.isEmpty {
           showAlertMsg(msg: "Enter High School marks")
            return false
        }
        return true
    }
    func graduationValidation()-> Bool {
        let graduat  = AppSession.share.miniProfileModel.graduationDetails
        if graduat.schoolName.isEmpty {
           showAlertMsg(msg: "Enter your Garduation Institution Name")
           return false
        }
        if graduat.subjectName.isEmpty {
           showAlertMsg(msg: "Enter your Garduation Course Name")
            return false
        }
        if graduat.awardingBody.isEmpty {
           showAlertMsg(msg: "Enter your Garduation Awarding Body")
            return false
        }
        if graduat.passingYear.isEmpty {
           showAlertMsg(msg: "Enter your Garduation year")
            return false
        }
        if graduat.marks.isEmpty {
           showAlertMsg(msg: "Enter your Garduation marks")
            return false
        }
        return true
    }
    
    func postGraduationValidation()-> Bool {
        let pg  = AppSession.share.miniProfileModel.postGraduationDetails
        if pg.schoolName.isEmpty {
           showAlertMsg(msg: "Enter your Post Garduation Institution Name")
           return false
        }
        if pg.subjectName.isEmpty {
           showAlertMsg(msg: "Enter your Post Garduation Course Name")
            return false
        }
        if pg.awardingBody.isEmpty {
           showAlertMsg(msg: "Enter your Post Garduation Awarding Body")
            return false
        }
        if pg.passingYear.isEmpty {
           showAlertMsg(msg: "Enter your Post Garduation year")
            return false
        }
        if pg.marks.isEmpty {
           showAlertMsg(msg: "Enter your Post Garduation marks")
            return false
        }
        return true
    }
}
