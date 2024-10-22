//
//  EnglishProficiencyCell.swift
//  CampusFrance
//
//  Created by UNICA on 25/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol EnglishProficiencyProtocol {
    func getSelectedScoreIeltsAndToeflibt(model:[String:Any])
}
class EnglishProficiencyCell: UITableViewCell {
    var profiencyArray  = [[ExamScoreModel]]()
    var delegate:EnglishProficiencyProtocol?
    var selectedIndex   = -1
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var table:UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configure(){
      prefill()
    }
    
    func prefill(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            if UserModel.getObject().profileCompleted == "Y"{
                let model = AppSession.share.miniProfileModel.thirdStep
                
                    if let ilets = model.englishExamLevel["IELTS"] as? String,ilets.isEmpty == false{
                        self.selectedIndex = Int(ilets)!
                    }
                
                     self.table.reloadData()
                self.delegate?.getSelectedScoreIeltsAndToeflibt(model:model.englishExamLevel)
            }
        }
        
        
    }
    ///  dict["IELTS"] = toeflModel.submodel[indexPath.row].id
  ///  dict["TOEFLIBT"] = ieltsModel.submodel[indexPath.row].id
}
//***********************************************//
// MARK: UITable View Methods
//***********************************************//
extension EnglishProficiencyCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  profiencyArray.count > 0 {
            if let model = profiencyArray[0].first {
                return model.submodel.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.englishSubCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    private func englishSubCell(indexPath: IndexPath) -> EnglishSubCell {
        let cell            = table.dequeueReusableCell(withIdentifier: "EnglishSubCell") as!EnglishSubCell
        if let model = profiencyArray.first {

            if let id =  model.first?.submodel[indexPath.row].id {
                if self.selectedIndex == Int(id) {
                        cell.layer.borderWidth   = 1
                    }else{
                        cell.layer.borderWidth   = 0
                    }
                }
            cell.level.text = model.first?.submodel[indexPath.row].title
            cell.elts.text = model.first?.submodel[indexPath.row].value
            cell.toefl.text = model.last?.submodel[indexPath.row].value
            cell.setupColor(index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = profiencyArray.first {
            if let id =  model.first?.submodel[indexPath.row].id {
                self.selectedIndex =  Int(id)!
            }
             addEnglishExam(row:indexPath.row)
        }
        
        
        
       tableView.reloadData()
    }
    
    
    func addEnglishExam(row:Int){
        if let model = profiencyArray.first, let toeflModel = model.first, let ieltsModel = model.last {
            var dict = [String:String]()
            if toeflModel.title == "IELTS" {
                dict["IELTS"] = toeflModel.submodel[row].id
                dict["TOEFLIBT"] = ieltsModel.submodel[row].id
            }else{
                dict["TOEFLIBT"] = ieltsModel.submodel[row].id
                dict["IELTS"] = toeflModel.submodel[row].id
            }
            delegate?.getSelectedScoreIeltsAndToeflibt(model:dict)
        }
    }
}


/*
 {"IELTS":"1","TOEFLIBT":"12"}
 
 */
