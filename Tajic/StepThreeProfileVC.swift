//
//  SetpThreeVC.swift
//  CampusFrance
//
//  Created by UNICA on 21/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//
import UIKit
class StepThreeProfileVC: UIViewController {
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var stepCounter: StepIndicatorView!
    @IBOutlet weak var bottomView: GradientView!
    @IBOutlet weak var tableView:UITableView!
    
    var previousModels:MiniProfileCommonModel!
    var cellHight       = 150
    var rowsNumber      = 1
    var firstRowHeight  = 151
    var secondRowHeight = 0
    var greCellHeight   = 0
    var gMatCellHeight  = 0
    var satCellHeiht    = 0
    var validScoreArray = [ExamScoreModel]()
    var proficencyArray = [[ExamScoreModel]]()
    var step3Model      = StepThreeModel()
    
    var selectedExamArray = [validScoreSeelctionModel]()
    var validInValidSeletion = "NoSelected"
    
    var isGreSelect = false
    var isGmatSelect = false
    var isSatSelect = false
    var courseArray = [CourseModel]()
    var stepOneMod = StepOneModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurations()
        let model = UserModel.getObject()
        if model.profileCompleted == "Y"{
            //  step3Model = AppSession.share.miniProfileModel.thirdStep
        }
        
    }
    func  configurations() {
        tableView.isHidden = true
        stepCounter.configureStep()
        gradientView.setGradientColor()
        addLeftMenuBtnOnNavigation()
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = UIColor.clear
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.getScores()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        
        let backBtn                                             = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        //add function for button
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        //set frame
        backBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(backBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = "Step - 2"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func nextBtnAction(_ sender: Any)
    {
        if validations(){
            
            let models =  MiniProfileCommonModel(model1: stepOneMod, model2: nil, model3: step3Model)
            
            
            let model =     MiniProfileViewModel()
            model.currentVC = self
            model.updateMiniProfile(models) { (bModel) in
                print(bModel.capacity)
            }
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: controllerName.stepFour.rawValue) as! StepFourProfileVC
//            previousModels.step3Model = step3Model
//            vc.previousModels = previousModels
//            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
//***********************************************//
// MARK: UITable view Delegates
//***********************************************//
extension StepThreeProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return validScoreCell(indexPath:indexPath)
        case 1: return englishProficiencyCell(indexPath:indexPath)
        case 2: return gREScoreCell(indexPath: indexPath)
        case 3: return gMATScoreCell(indexPath: indexPath)
        default:return sATScoreCell(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return CGFloat(firstRowHeight)
        case 1:return CGFloat(secondRowHeight)
        case 2:return CGFloat(greCellHeight)
        case 3:return CGFloat(gMatCellHeight)
        case 4:return CGFloat(satCellHeiht)
        default:return 100
        }
    }
}

//***********************************************//
// MARK: UITable View Cell's Object
//***********************************************//
extension StepThreeProfileVC {
    private func validScoreCell(indexPath:IndexPath) -> ValidScoreCell {
        let cell                = tableView.dequeueReusableCell(withIdentifier: "ValidScoreCell") as! ValidScoreCell
        cell.validScoreDelegate = self
        cell.validScoreArray    = validScoreArray
        cell.greGmatSatDelegate = self
        cell.selectedExamArray = selectedExamArray
        cell.configureTable()
        return cell
    }
    
    private func englishProficiencyCell(indexPath:IndexPath) -> EnglishProficiencyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnglishProficiencyCell") as! EnglishProficiencyCell
        cell.profiencyArray =  proficencyArray
        cell.delegate       = self
        cell.table.reloadData()
        if proficencyArray.isEmpty == false{
            cell.prefill()
        }
        
        return cell
    }
    private func gREScoreCell(indexPath:IndexPath) -> GREScoreCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GREScoreCell") as! GREScoreCell
        cell.delegate = self
        cell.prefillData()
        cell.profileUpdate()
        return cell
    }
    
    private func gMATScoreCell(indexPath:IndexPath) -> GMATScoreCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GMATScoreCell") as! GMATScoreCell
        cell.delegate = self
        cell.prefillData()
        cell.profileUpdate()
        return cell
    }
    
    private func sATScoreCell(indexPath:IndexPath) -> SATScoreCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SATScoreCell") as! SATScoreCell
        cell.delegate = self
        cell.prefillData()
        cell.profileUpdate()
        return cell
    }
}

//***********************************************//
// MARK: Protocols for collect selected Data
//***********************************************//
extension StepThreeProfileVC:validScoreProtocol{
    
    func validScoreTableDynamicHeight(modifiedArray:[ExamScoreModel], selectedExamArray: [validScoreSeelctionModel]) {
        firstRowHeight  = 151
        validScoreArray = modifiedArray
        modifiedArray.forEach { (model) in
            if model.isShowSubMenu {
                firstRowHeight += model.rowHeight
            }
        }
        firstRowHeight +=  modifiedArray.count*60
        self.selectedExamArray = selectedExamArray
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    func validScoreTapped() {
        secondRowHeight = 0
        step3Model.isValidScore = "true"
        firstRowHeight  = 151
        firstRowHeight += validScoreArray.count*60
        validScoreArray.forEach { (model) in
            model.isShowSubMenu = false
        }
        rowsNumber = 1
        validInValidSeletion =  "validScore"
        tableView.reload(tableView:tableView)
    }
    
    func notValidScoreTapped() {
        step3Model.isValidScore = "false"
        firstRowHeight          = 151
        secondRowHeight         = 70
        greCellHeight           = 0
        gMatCellHeight          = 0
        satCellHeiht            = 0
        proficencyArray.forEach { (model) in
            secondRowHeight  += model[0].submodel.count*50
        }
        rowsNumber = 2
        tableView.reload(tableView:tableView)
        validInValidSeletion =  "notValidScore"
    }
    
    func getPassedExamDetails(model: [[String : String]]) {
        step3Model.qualifiedExams = model
    }
    
}
//***********************************************//
// MARK: English profiency
//***********************************************//
extension StepThreeProfileVC:EnglishProficiencyProtocol{
    func getSelectedScoreIeltsAndToeflibt(model: [String : Any]) {
        AppSession.share.miniProfileModel.thirdStep.englishExamLevel = model
        step3Model.englishExamLevel = model
        print(model)
    }
}

//***********************************************//
// MARK: GreMat protocol
//***********************************************//
extension StepThreeProfileVC:gReGmatSatProtocol{
    func greTappedWith(isShow: Bool, model: [ExamScoreModel]?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            if isShow {
                self.greCellHeight   = 400
                self.isGreSelect = true
            }else{
                self.greCellHeight   = 0
                self.isGreSelect = false
            }
            self.rowsNumber = 5
            self.tableView.reload(tableView:self.tableView)
            
        }
    }
    func gMatTappedWith(isShow: Bool, model: [ExamScoreModel]?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if isShow {
                self.gMatCellHeight  = 500
                self.isGmatSelect = true
            }else{
                self.gMatCellHeight  = 0
                self.isGmatSelect = false
                
            }
            self.rowsNumber = 5
            self.tableView.reload(tableView:self.tableView)
        }
    }
    
    func gSatTappedWith(isShow: Bool, model: [ExamScoreModel]?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if isShow{
                self.satCellHeiht    =  350
                self.isSatSelect = true
            }else{
                self.satCellHeiht    =  0
                self.isSatSelect = false
            }
            self.rowsNumber = 5
            self.tableView.reload(tableView:self.tableView)
        }
    }
}

//***********************************************//
// MARK: Gre score protocol
//***********************************************//
extension StepThreeProfileVC:greScoreProtocol{
    func getGreAllFields(model: GreScoreModel) {
        step3Model.greVerbal                 = model.greVarblePercent
        step3Model.greVerbalScore            = model.greVerbal
        step3Model.greQuantitative           =  model.quantitativePercent
        step3Model.greQuantitativeScore      =  model.quantitative
        step3Model.greAnalyticalWriting      = model.analyticalWritingPercent
        step3Model.greAnalyticalWritingScore = model.analyticalWriting
        step3Model.greExamDate               = model.greDate
    }
}

//***********************************************//
// MARK: GMATScoreCellProtocol
//***********************************************//
extension StepThreeProfileVC:GMATScoreCellProtocol{
    func getGmatScoreModel(model: GMATScoreModel) {
        step3Model.gMatExamDate               = model.gmatDate
        step3Model.gMatVerbal                 = model.gmatVarblePercent
        step3Model.gMatVerbalScore            = model.gmatVerbal
        step3Model.gMatQuantitative           = model.gmatquantitativePercent
        step3Model.gMatQuantitativeScore      = model.gmatquantitative
        step3Model.gMatAnalyticalWriting      = model.gmatanalyticalWritingPercent
        step3Model.gMatAnalyticalWritingScore =  model.gmatanalyticalWriting
        step3Model.gMatTotalScore             = model.gmatTotalScore
        step3Model.gMatTotalScorePer          = model.gmatTotalScorePercent
    }
}
//***********************************************//
// MARK: Sat protocol
//***********************************************//
extension StepThreeProfileVC:satScoreProtocol{
    func getSelectedSatDetails(model:SATScoreModel){
        step3Model.sAtExamDare             = model.sAtDate
        step3Model.sAtRawScore             = model.sAtRawScore
        step3Model.sAtMathScore            = model.sAtMathScore
        step3Model.sAtReadingScore         = model.sAtReadingScore
        step3Model.sAtWritingLanguageScore = model.sAtLanguageScore
        step3Model.sAtWritingScore         = model.sAtWritingScore
    }
}



extension StepThreeProfileVC{
    func validations()-> Bool {
        print("\(step3Model.qualifiedExams.isEmpty),isSatSelect \(isSatSelect) ,isGmatSelect \(isGmatSelect),isGreSelect \(isGreSelect)")
        switch validInValidSeletion {
            
            
        case "NoSelected": showAlertMsg(msg: "Please Select your Scores")
        return false
        case "notValidScore": return true
//            if  step3Model.englishExamLevel.keys.isEmpty {
//            showAlertMsg(msg: "Please Select your English Proficiency")
//            return false
//            }
        case "validScore": if step3Model.qualifiedExams.isEmpty && isSatSelect == false && isGmatSelect == false && isGreSelect == false  {
            showAlertMsg(msg: "Please Select Your valid score")
            return false
        }
        
        if step3Model.qualifiedExams.isEmpty == false {
            if step3Model.qualifiedExams.count != selectedExamArray.count {
                showAlertMsg(msg: "Please select score")
                return false
            }else{
                var array = [String]()
                step3Model.qualifiedExams.forEach { (dict) in
                    if let key = dict["score_id"], key.isEmpty == true   {
                        array.append(key)
                    }
                }
                
                
                if array.count != 0 {
                    showAlertMsg(msg: "Please select score")
                    return false
                }
            }
        }
        
        
        if isGreSelect {
            if step3Model.greExamDate.isEmpty {
                showAlertMsg(msg: "Please select GRE Exam date")
                return false
            }
                //// Gre values validations  // greVerbalScore "Enter Gre Verbal Percentage Score"
            else if    step3Model.greVerbalScore.isEmpty  {
                showAlertMsg(msg: "Enter valid GRE Verbal score")
                return false
            }else if let greVerbal = Float(step3Model.greVerbalScore),greVerbal < 130.00 || greVerbal > 170.00  {
                showAlertMsg(msg: "Enter valid GRE Verbal score")
                return false
            }
               
                
            else if  step3Model.greVerbal.isEmpty{
                showAlertMsg(msg: "Enter GRE Verbal Percentage Score")
                return false
            }else if  let greVerbal =  Float(step3Model.greVerbal),greVerbal > 100.00   {
                showAlertMsg(msg: "Enter GRE Verbal Percentage Score")
                return false
            }
                
            else if    step3Model.greQuantitativeScore.isEmpty {
                showAlertMsg(msg: "Enter valid GRE Quantitative score")
                return false
            }else if let quant = Float(step3Model.greQuantitativeScore), quant < 130.00 || quant > 170.00  {
                showAlertMsg(msg: "Enter valid GRE Quantitative score")
                return false
            }
                
                
            else if  step3Model.greQuantitative.isEmpty{
                showAlertMsg(msg: "Enter valid GRE Quantitative Score Percentage")
                return false
            }else if  let quant =  Float(step3Model.greQuantitative),quant > 100.00 {
                showAlertMsg(msg: "Enter valid GRE Quantitative Score Percentage")
                return false
            }
                
                
                
                
                
                // greAnalyticalWriting
            else if  step3Model.greAnalyticalWritingScore.isEmpty{
                showAlertMsg(msg: "Enter  GRE Analytical score")
                return false
            }  else if  let greAn = Float(step3Model.greAnalyticalWritingScore), greAn > 6.00 {
                showAlertMsg(msg: "Enter  GRE Analytical score")
                return false
            }
                
            else if step3Model.greAnalyticalWriting.isEmpty{
                showAlertMsg(msg: "Enter  GRE Analytical Percentage")
                return false
            } else if let ana = Float(step3Model.greAnalyticalWriting), ana > 100.00 {
                showAlertMsg(msg: "Enter  GRE Analytical Percentage")
                return false
            }
            
            /// Gmat validations
        }
        if isGmatSelect {
            let  gMatModel = AppSession.share.gMATScoreModel
            
            
            
            
            if step3Model.gMatExamDate.isEmpty {
                showAlertMsg(msg: "Plase Select GMAT Exam Date")
                return false
            }
            else if gMatModel.gmatVerbal.isEmpty  {
                showAlertMsg(msg: "Enter GMAT Verbal")
                return false
            }
            else if let gmatverbal = Float(gMatModel.gmatVerbal), gmatverbal < 130.00 || gmatverbal > 170.00  {
                showAlertMsg(msg: "Enter GMAT Verbal")
                return false
            }else if  gMatModel.gmatVarblePercent.isEmpty{
                showAlertMsg(msg: "Enter GMAT Verbal percentage")
                return false
            }else if  let score = Float(gMatModel.gmatVarblePercent),score > 100.00 {
                showAlertMsg(msg: "Enter GMAT Verbal percentage")
                return false
            }
                
            else if gMatModel.gmatquantitative.isEmpty{
                showAlertMsg(msg: "Enter GMAT Quantitative Score")
                return false
            }else if let gmatQuantScore = Float(gMatModel.gmatquantitative),gmatQuantScore < 130.00 || gmatQuantScore > 170.00 {
                showAlertMsg(msg: "Enter GMAT Quantitative Score")
                return false
            }
                
                
                
            else if  gMatModel.gmatquantitativePercent.isEmpty{
                showAlertMsg(msg: "Enter GMAT Quantitative percentage")
                return false
            }else if let gMatQuantitative = Float( gMatModel.gmatquantitativePercent)  ,  gMatQuantitative > 100.00  {
                showAlertMsg(msg: "Enter GMAT Quantitative percentage")
                return false
            }
            else if  gMatModel.gmatanalyticalWriting.isEmpty  {
                showAlertMsg(msg: "Enter GMAT Analytical score")
                return false
            }
            else if  let gmatanWr = Float( gMatModel.gmatanalyticalWriting),gmatanWr > 6.00  {
                showAlertMsg(msg: "Enter GMAT Analytical score")
                return false
            }
                
                
                
            else if  gMatModel.gmatanalyticalWritingPercent.isEmpty{
                showAlertMsg(msg: "Enter GMAT Analytical percentage")
                return false
            }else if let gMatAnalyticalWriting = Float( gMatModel.gmatanalyticalWritingPercent), gMatAnalyticalWriting > 100.00 {
                showAlertMsg(msg: "Enter GMAT Analytical percentage")
                return false
            }
                
                
            else  if  gMatModel.gmatTotalScore.isEmpty {
                showAlertMsg(msg: "Enter GMAT total score")
                return false
            }
            else  if let percent = Float(gMatModel.gmatTotalScore), percent < 1.00  {
                showAlertMsg(msg: "Enter GMAT total score")
                return false
            }
                // gmat total score gMatTotalScore "Enter GMAT total score"
            else if   gMatModel.gmatTotalScorePercent.isEmpty {
                showAlertMsg(msg: "Enter GMAT total percentage")
                return false
            } else if let score = Float(gMatModel.gmatTotalScorePercent),score > 100.00  {
                showAlertMsg(msg: "Enter GMAT total percentage")
                return false
            }
            
            // Sat Validations
        }
        if isSatSelect {
            if  step3Model.sAtExamDare.isEmpty {
                showAlertMsg(msg: "Plase Select SAT Exam Date")
                return false
            }else if  step3Model.sAtRawScore.isEmpty{
                showAlertMsg(msg: "Enter SAT Raw")
                return false
            }else if  step3Model.sAtMathScore.isEmpty{
                showAlertMsg(msg: "Enter SAT Math Score")
                return false
            }else if  step3Model.sAtReadingScore.isEmpty{
                showAlertMsg(msg: "Enter SAT Reading Score")
                return false
            }else if step3Model.sAtWritingScore.isEmpty{
                showAlertMsg(msg: "Enter SAT Writing Score")
                return false
            }else if step3Model.sAtWritingLanguageScore.isEmpty{
                showAlertMsg(msg: "Enter SAT Language Score")
                return false
            }
            }
        default:break
        }
        return true
        
    }
    
    
    
    
}
//***********************************************//
// MARK: Get score sevrice
//***********************************************//
extension StepThreeProfileVC {
    func  getScores(){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        
        ActivityView.show()
        WebServiceManager.instance.studentFetchValidWithDetails { [weak self](status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any], let detailsArray = data["exams"] as? [[String:Any]] {
                    var proArray = [ExamScoreModel]()
                    detailsArray.forEach({ (dict) in
                        let model = ExamScoreModel(with:dict )
                        self?.validScoreArray.append(model)
                        
                        
                        switch model.title {
                        case "IELTS":  proArray.append(model)
                        case "TOEFL IBT":proArray.append(model)
                        default:
                            break
                        }
                    })
                    
                    if UserModel.getObject().profileCompleted == "Y"{
                        let qualifiedExams = AppSession.share.miniProfileModel.thirdStep.qualifiedExams
                        
                        print(qualifiedExams)
                        for (_, exModel) in (self?.validScoreArray.enumerated())! {
                            qualifiedExams.forEach({ (dict) in
                                if let id = dict["exam_id"],exModel.id == id,let scoreId = dict["score_id"] {
                                    exModel.isShowSubMenu = true
                                    for (_, subValue) in exModel.submodel.enumerated(){
                                        if scoreId == subValue.id {
                                            subValue.isSelected = true
                                        }
                                    }
                                }
                            })
                        }
                    }
                    
                    self?.proficencyArray.append(proArray)
                    self?.rowsNumber = 5
                    self!.tableView.reload(tableView:self!.tableView)
                    self!.tableView.isHidden = false
                    self?.checkToFillScores()
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
    
    func checkToFillScores(){
        if UserModel.getObject().profileCompleted == "Y"{
            let qualifiedExams = AppSession.share.miniProfileModel.thirdStep.qualifiedExams
            
            print(qualifiedExams)
            for (_, exModel) in validScoreArray.enumerated() {
                qualifiedExams.forEach({ (dict) in
                    if let id = dict["exam_id"],exModel.id == id,let scoreId = dict["score_id"] {
                        exModel.isShowSubMenu = true
                        for (_, subValue) in exModel.submodel.enumerated(){
                            if scoreId == subValue.id {
                                subValue.isSelected = true
                            }
                        }
                    }
                })
            }
            tableView.reload(tableView:tableView)
        }
    }
}
