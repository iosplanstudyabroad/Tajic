//
//  GMATScoreCell.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol GMATScoreCellProtocol  {
    func getGmatScoreModel(model:GMATScoreModel)
}
class GMATScoreCell: UITableViewCell {
    @IBOutlet weak var card: UIView!
    @IBOutlet var textArray: [TextInset]!
    @IBOutlet weak var Date: TextInset!
    @IBOutlet weak var Verbal: TextInset!
    @IBOutlet weak var VarblePercent: TextInset!
    @IBOutlet weak var quantitative: TextInset!
    @IBOutlet weak var quantitativePercent: TextInset!
    @IBOutlet weak var analyticalWriting: TextInset!
    @IBOutlet weak var analyticalWritingPercent: TextInset!
    @IBOutlet weak var totalScore: TextInset!
    @IBOutlet weak var totalScorePercent: TextInset!
    
    var model = GMATScoreModel()
    var delegate: GMATScoreCellProtocol?
    
    var currentDate:Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
        setUpTextFields()
        self.selectionStyle = .none
    }

    func setUpTextFields(){
        textArray.forEach { (button) in
            button.layer.cornerRadius  = 5
            button.layer.masksToBounds = true
            button.layer.borderColor   = UIColor.lightGray.cgColor
            button.layer.borderWidth   = 1
            button.keyboardType        =  .decimalPad
            //button.maxLength    = 6
            button.delegate            = self
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        datePicker()
    }
    
}



extension GMATScoreCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let result = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
                           guard !result.isEmpty else { return true }
                           let numberFormatter = NumberFormatter()
                           numberFormatter.numberStyle = .none
                   if let _ = numberFormatter.number(from: result)?.floatValue {
                       updateModelAsPerTextField(text: result, tag: textField.tag)
                   }
        
        /*
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        updateModelAsPerTextField(text: result, tag: textField.tag)*/
        return true
    }
    
    func updateModelAsPerTextField(text:String,tag:Int){
        guard text.isEmpty == false else {
            return
        }
        switch tag {
        case 10:model.gmatVerbal                   = text
        case 20:model.gmatVarblePercent            = text
        case 30:model.gmatquantitative             = text
        case 40:model.gmatquantitativePercent      = text
        case 50:model.gmatanalyticalWriting        = text
        case 60:model.gmatanalyticalWritingPercent = text
        case 70:model.gmatTotalScore               = text
        case 80:model.gmatTotalScorePercent        = text
        default:break
        }
        AppSession.share.gMATScoreModel = model
        delegate?.getGmatScoreModel(model: model)
    }
    
    func datePicker(){
        let pickerView = Bundle.main.loadNibNamed("DateSelectorView", owner: self, options: nil)![0] as?
        DateSelectorView
        pickerView?.frame = (AppDelegate.shared.window?.rootViewController?.view.frame)!
        pickerView?.delegate = self
        if let date = currentDate {
         pickerView?.selectedDate = date
        }
        pickerView?.isDobValidation = false
        pickerView?.setupPickers()
        AppDelegate.shared.window!.rootViewController?.view.addSubview(pickerView!)
        
        
       
       
    }
}

extension GMATScoreCell:dateProtocol{
    func selectedDate(date: Date) {
        Date.text     = ISO8601DateFormatter().convertDate(date)
        model.gmatDate = ISO8601DateFormatter().convertDate(date)
        delegate?.getGmatScoreModel(model: model)
        currentDate = date
    }
    
    
    func profileUpdate(){
        if UserModel.getObject().profileCompleted == "Y" {
            let matModel                       = AppSession.share.miniProfileModel.thirdStep
            model.gmatDate                     = matModel.gMatExamDate
            model.gmatVerbal                   = matModel.gMatVerbalScore
            model.gmatVarblePercent            = matModel.gMatVerbal
            model.gmatquantitative             = matModel.gMatQuantitativeScore
            model.gmatquantitativePercent      = matModel.gMatQuantitative
            model.gmatanalyticalWriting        = matModel.gMatAnalyticalWritingScore
            model.gmatanalyticalWritingPercent = matModel.gMatAnalyticalWriting
            model.gmatTotalScore               = matModel.gMatTotalScore
            model.gmatTotalScorePercent        = matModel.gMatTotalScorePer
            AppSession.share.gMATScoreModel = model
            delegate?.getGmatScoreModel(model: model)
        }
    }
    func prefillData(){
            model                         = AppSession.share.gMATScoreModel
            Date.text = model.gmatDate
            Verbal.text                   = model.gmatVerbal
            VarblePercent.text            = model.gmatVarblePercent
            quantitative.text             = model.gmatquantitative
            quantitativePercent.text      = model.gmatquantitativePercent
            analyticalWriting.text        = model.gmatanalyticalWriting
            analyticalWritingPercent.text = model.gmatanalyticalWritingPercent
            totalScore.text               = model.gmatTotalScore
            totalScorePercent.text        = model.gmatTotalScorePercent
    }
}
