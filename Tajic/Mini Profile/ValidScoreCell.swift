//
//  ValidScoreCell.swift
//  CampusFrance
//
//  Created by UNICA on 25/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
protocol validScoreProtocol:class {
    func validScoreTapped()
    func notValidScoreTapped()
    func validScoreTableDynamicHeight(modifiedArray:[ExamScoreModel], selectedExamArray: [validScoreSeelctionModel])
    func getPassedExamDetails(model:[[String:String]])
    
}

protocol  gReGmatSatProtocol {
    func greTappedWith(isShow:Bool,model:[ExamScoreModel]?)
    func gMatTappedWith(isShow:Bool,model:[ExamScoreModel]?)
    func gSatTappedWith(isShow:Bool,model:[ExamScoreModel]?)
}
class ValidScoreCell: UITableViewCell {
    var validScoreDelegate:validScoreProtocol?
    var greGmatSatDelegate:gReGmatSatProtocol?
    @IBOutlet weak var notValidRadioImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var validRadioImage: UIImageView!
    @IBOutlet weak var table:UITableView!
    var validScoreArray = [ExamScoreModel]()
    var selectedExamArray = [validScoreSeelctionModel]()
    var selectedSubSection   = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.cardView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTable(){
       // preSelectValidCourses()
        table.reload(tableView: table)
        setCheckUncheckImage()
        autoCheckPreselected()
    }
    
    func autoCheckPreselected(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            if UserModel.getObject().profileCompleted == "Y" && AppSession.share.isFirstLoadSelect == false {
                AppSession.share.isFirstLoadSelect = true
                let model = AppSession.share.miniProfileModel.thirdStep
                if model.isValidScore == "true" {
                    self.validScoreTappMethod()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                        self.preSelectValidCourses()
                    }
                }else{
                    self.iNvalidScoreTappMethod()
                }
               
            }
        }
    }
    
    
    func preSelectValidCourses(){
      let qualifiedExams = AppSession.share.miniProfileModel.thirdStep.qualifiedExams
        // addRemoveValues(with:section)
        ///self.table.reloadData()
         var array = [[String:String]]()
        self.selectedExamArray.removeAll()
        for (section, exModel) in validScoreArray.enumerated() {
            qualifiedExams.forEach({ (dict) in
                
                if let exam_id = dict["exam_id"] {
                    switch exam_id {
                    case "5" : greGmatSatDelegate?.greTappedWith(isShow:true, model:nil )
                    if  exam_id == exModel.id {
                        let smodel            = validScoreSeelctionModel()
                        smodel.selectedSubMenuId = "input"
                        smodel.selectedMenuId = exModel.id
                        smodel.index           = section
                        selectedExamArray.append(smodel)
                        array.append(smodel.dataDict)
                        }
                    case "6": greGmatSatDelegate?.gMatTappedWith(isShow:true, model: nil)
                    if  exam_id == exModel.id {
                        let smodel            = validScoreSeelctionModel()
                        smodel.selectedSubMenuId = "input"
                        smodel.selectedMenuId = exModel.id
                        smodel.index           = section
                        selectedExamArray.append(smodel)
                        array.append(smodel.dataDict)
                    }
                    
                    
                    case "7" : greGmatSatDelegate?.gSatTappedWith(isShow: true, model: nil)
                    if  exam_id == exModel.id {
                        let smodel            = validScoreSeelctionModel()
                        smodel.selectedSubMenuId = "input"
                        smodel.selectedMenuId = exModel.id
                        smodel.index           = section
                        selectedExamArray.append(smodel)
                        array.append(smodel.dataDict)
                        }
                    default: print("no")
                    }
                }
                
                if let id = dict["exam_id"],exModel.id == id {
                    if let score = dict["score_id"] {
                        exModel.isShowSubMenu = true
                        print(exModel.title)
                        //
                        
                        exModel.submodel.forEach({ (model) in
                            if model.id == score {
                                let smodel            = validScoreSeelctionModel()
                                smodel.selectedMenuId = exModel.id
                                smodel.selectedSubMenuId  = model.id
                                
                                smodel.index           = section
                                print(exModel.title)
                                selectedExamArray.append(smodel)
                                array.append(smodel.dataDict)
                            }
                        })
                    }
                }
                
            })
            
        }
        
     
     //   let newSet = ExamSet as? [validScoreSeelctionModel]
     
        
  validScoreDelegate?.validScoreTableDynamicHeight(modifiedArray: validScoreArray, selectedExamArray: selectedExamArray)
       validScoreDelegate?.getPassedExamDetails(model:array)
        
        
      //   table.reloadData()
        return
    }
    
   
    
    func filterExamdata(dataArray:[[String:String]],dict:[String:String])-> Bool {
        if dataArray.contains(dict){
         return false
        }else{
         return true
        }
    }
    
    
    func selectCell(section:Int, row:Int){
        if  let scoreId = validScoreArray[section].submodel[row].id  {
            var array = [[String:String]]()
            
            if let index = selectedExamArray.firstIndex(where: { $0.index == section}){
                selectedExamArray[index].selectedSubMenuId = scoreId
            }
            
            selectedExamArray.forEach { (model) in
                array.append(model.dataDict)
            }
            
            validScoreDelegate?.getPassedExamDetails(model:array)
            validScoreArray[section].submodel.forEach { (model) in
                model.isSelected = false
            }
            validScoreArray[section].submodel[row].isSelected = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                
                self.table.reload(tableView: self.table)
            }
            
        }
        
        
        
        
    }
    
    
    
    
    func check(with tag:Int){
        if validScoreArray[tag].isShowSubMenu {
            if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                print(index)
            }else{
                let model            = validScoreSeelctionModel()
                model.index          = tag
                model.selectedMenuId = validScoreArray[tag].id
                model.selectedSubMenuId = "input"
                selectedExamArray.append(model)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    var array = [[String:String]]()
                    self.selectedExamArray.forEach { (model) in
                        array.append(model.dataDict)
                    }
                    self.validScoreDelegate?.getPassedExamDetails(model:array)
                }
            }
            
        }else{
            if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                selectedExamArray.remove(at: index)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    var array = [[String:String]]()
                    self.selectedExamArray.forEach { (model) in
                        array.append(model.dataDict)
                    }
                    self.validScoreDelegate?.getPassedExamDetails(model:array)
                }
            }
        }
        self.table.reloadSections(IndexSet(integer: tag), with: .none)
        
        validScoreDelegate?.validScoreTableDynamicHeight(modifiedArray: sortArray(tag: tag), selectedExamArray: selectedExamArray)
    }
    
    
    
    
    
    
    
    func setCheckUncheckImage(){
        switch AppSession.share.iHaveValidScore {
        case "": notValidRadioImage.image = radioUnChecked
        validRadioImage.image             = radioUnChecked
        case "validScore" :
            validRadioImage.image         = radioChecked
            notValidRadioImage.image      = radioUnChecked
        case "notValidScore":
            notValidRadioImage.image      = radioChecked
            validRadioImage.image         = radioUnChecked
        default:break
        }
    }
    /// iHaveValidScore
    @IBAction func notHaveValidScoreBtnTapped(_ sender: Any) {
       iNvalidScoreTappMethod()
    }
    
    @IBAction func haveValidScoreBtnTapped(_ sender: Any) {
       validScoreTappMethod()
    }
    
    func validScoreTappMethod(){
        validRadioImage.image    = radioChecked
        notValidRadioImage.image = radioUnChecked
        validScoreDelegate?.validScoreTapped()
        AppSession.share.iHaveValidScore = "validScore"
        setCheckUncheckImage()
    }
    
    func iNvalidScoreTappMethod(){
        notValidRadioImage.image = radioChecked
        validRadioImage.image    = radioUnChecked
        validScoreDelegate?.notValidScoreTapped()
        AppSession.share.iHaveValidScore = "notValidScore"
        setCheckUncheckImage()
    }
    
    }
    

extension ValidScoreCell:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return validScoreArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  validScoreArray[section].isShowSubMenu == true{
            return validScoreArray[section].submodel.count
        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.scoreCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return attachView(width:Double(tableView.frame.size.width+20) , isSelected: validScoreArray[section].isShowSubMenu, sectionName: validScoreArray[section].title, tag: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 0.00001
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    private func scoreCell(indexPath: IndexPath) -> ScoreCell {
        let cell            = table.dequeueReusableCell(withIdentifier: "ScoreCell") as!ScoreCell
        cell.configureCell(model:validScoreArray[indexPath.section].submodel[indexPath.row] )
        
        let subModel = validScoreArray[indexPath.section].submodel
        
        print("selected status:- \(subModel[indexPath.row].isSelected) at \(indexPath.row)")
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectSubModel(section: indexPath.section, row: indexPath.row)
    }
  
    func selectSubModel(section:Int, row:Int){
        if  let scoreId = validScoreArray[section].submodel[row].id  {
            var array = [[String:String]]()
            
            if let index = selectedExamArray.firstIndex(where: { $0.index == section}){
                selectedExamArray[index].selectedSubMenuId = scoreId
            }
            
            selectedExamArray.forEach { (model) in
                array.append(model.dataDict)
            }
            
            validScoreDelegate?.getPassedExamDetails(model:array)
            validScoreArray[section].submodel.forEach { (model) in
                model.isSelected = false
            }
            validScoreArray[section].submodel[row].isSelected = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                
                self.table.reload(tableView: self.table)
            }
            
        }
        
        
        
        
    }
    
    
}

extension ValidScoreCell{
    @objc func handleTap(gesture: UIGestureRecognizer)
    {
        print(validScoreArray[tag].isShowSubMenu)
        if let tag = gesture.view?.tag {
            validScoreArray[tag].isShowSubMenu = !validScoreArray[tag].isShowSubMenu
            switch validScoreArray[tag].title {
            case "GRE" : greGmatSatDelegate?.greTappedWith(isShow: validScoreArray[tag].isShowSubMenu, model:sortArray(tag: tag) )
                addRemoveValues(with: tag)
            case "GMAT": greGmatSatDelegate?.gMatTappedWith(isShow: validScoreArray[tag].isShowSubMenu, model: sortArray(tag: tag))
                addRemoveValues(with: tag)
            case "SAT" : greGmatSatDelegate?.gSatTappedWith(isShow: validScoreArray[tag].isShowSubMenu, model: sortArray(tag: tag))
                addRemoveValues(with: tag)
            default:
          
                if validScoreArray[tag].isShowSubMenu {

                    if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                        print(index)
                    }else{
                        
                        let model            = validScoreSeelctionModel()
                        model.index          = tag
                        model.selectedMenuId = validScoreArray[tag].id
                        if selectedExamArray.contains(model){
                            
                        }else{
                         selectedExamArray.append(model)
                        }
                        
                    }
                }else{
                    if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                       selectedExamArray.remove(at: index)
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            var array = [[String:String]]()
                            self.selectedExamArray.forEach { (model) in
                                array.append(model.dataDict)
                            }
                            self.validScoreDelegate?.getPassedExamDetails(model:array)
                        }
                    }
                }
                validScoreDelegate?.validScoreTableDynamicHeight(modifiedArray: sortArray(tag: tag), selectedExamArray: selectedExamArray)
            }
            self.table.reloadSections(IndexSet(integer: tag), with: .none)
        }
    }
    
    func sortArray(tag:Int)->[ExamScoreModel]{
        if validScoreArray[tag].isShowSubMenu {
            validScoreArray[tag].submodel.forEach { (model) in
                model.isSelected = false
            }
        }
        return validScoreArray
    }
    
    
    
    func addRemoveValues(with tag:Int){
        if validScoreArray[tag].isShowSubMenu {
            if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                print(index)
            }else{
                let model            = validScoreSeelctionModel()
                model.index          = tag
                model.selectedMenuId = validScoreArray[tag].id
                model.selectedSubMenuId = "input"
                selectedExamArray.append(model)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    var array = [[String:String]]()
                    self.selectedExamArray.forEach { (model) in
                        array.append(model.dataDict)
                    }
                    self.validScoreDelegate?.getPassedExamDetails(model:array)
                }
            }
            
        }else{
            if let index = selectedExamArray.firstIndex(where: { $0.index == tag}){
                selectedExamArray.remove(at: index)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    var array = [[String:String]]()
                    self.selectedExamArray.forEach { (model) in
                        array.append(model.dataDict)
                    }
                    self.validScoreDelegate?.getPassedExamDetails(model:array)
                }
            }
        }
         self.table.reloadSections(IndexSet(integer: tag), with: .none)
        
          validScoreDelegate?.validScoreTableDynamicHeight(modifiedArray: sortArray(tag: tag), selectedExamArray: selectedExamArray)
    }
}

extension ValidScoreCell {
    func attachView(width:Double,isSelected:Bool,sectionName:String,tag:Int)->UIView{
        
        print(isSelected,sectionName,tag)
        let view             = UIView()
        view.frame           = CGRect(x: 0, y: 0, width: width, height: 60)
        let image            = UIImageView(frame: CGRect(x: 30, y: 20, width: 20, height: 20))
        image.image       = uncheckSquare
        if isSelected {
            image.image       = checkSquare
        }else{
            image.image       = uncheckSquare
        }
        let label            = UILabel(frame: CGRect(x: 60, y: 0, width: width - 45, height: 60))
        label.text           = sectionName
        label.font           = UIFont.systemFont(ofSize: 20.0)
        view.addSubview(image)
        view.addSubview(label)
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "#E1EEFC")
        view.tag             = tag
        let tapRecognizer                     = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate                = self
        tapRecognizer.numberOfTapsRequired    = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
       
        return view
    }
}





//class validScoreSeelctionModel:NSObject{
//    var index             = -1
//    var selectedMenuId    = ""
//    var selectedSubMenuId = ""
//    var dataDict:[String:String]{
//        return ["exam_id":selectedMenuId,"score_id":selectedSubMenuId]
//    }
//
//}




extension Array where Element: Hashable {
    var setValue: Set<Element> {
        return Set<Element>(self)
    }
}


