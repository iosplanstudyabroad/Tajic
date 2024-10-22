//
//  SATScoreCell.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol satScoreProtocol {
    func getSelectedSatDetails(model:SATScoreModel)
}
class SATScoreCell: UITableViewCell {
    @IBOutlet var textFieldArray: [TextInset]!
    @IBOutlet weak var dateText: TextInset!
    
    @IBOutlet weak var rawScore: TextInset!
    
    
    @IBOutlet weak var mathScore: TextInset!
    
    
    @IBOutlet weak var readingScore: TextInset!
    
    @IBOutlet weak var writingScore: TextInset!
    
    @IBOutlet weak var languageScore: TextInset!
    
    
    
    
    @IBOutlet weak var card: UIView!
    
    var model = SATScoreModel()
    var delegate: satScoreProtocol?
    var currentDate = Date()
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
        setUpTextFields()
        self.selectionStyle = .none
    }

    func setUpTextFields(){
        textFieldArray.forEach { (text) in
            text.layer.cornerRadius  = 5
            text.layer.masksToBounds = true
            text.layer.borderColor   = UIColor.lightGray.cgColor
            text.layer.borderWidth   = 1
            text.delegate            = self
            text.keyboardType        = .decimalPad
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func dateBtnTapped(_ sender:UIButton){
        datePicker()
    }

}

extension SATScoreCell:UITextFieldDelegate{
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
        case 10:model.sAtRawScore      = text
        case 20:model.sAtMathScore     = text
        case 30:model.sAtReadingScore  = text
        case 40:model.sAtWritingScore  = text
        case 50:model.sAtLanguageScore = text
        default:break
        }
        AppSession.share.sATScoreModel = model
        delegate?.getSelectedSatDetails(model: model)
    }
    
    func datePicker(){
        let pickerView = Bundle.main.loadNibNamed("DateSelectorView", owner: self, options: nil)![0] as?
        DateSelectorView
        pickerView?.frame = UIScreen.main.bounds
        pickerView?.delegate = self
         pickerView?.selectedDate = currentDate
        pickerView?.isDobValidation = false
         pickerView?.setupPickers()
        AppDelegate.shared.window!.rootViewController?.view.addSubview(pickerView!)
    }
}

extension SATScoreCell:dateProtocol{
    func selectedDate(date: Date) {
        dateText.text  = ISO8601DateFormatter().convertDate(date)
        model.sAtDate = ISO8601DateFormatter().convertDate(date)
        delegate?.getSelectedSatDetails(model: model)
        currentDate = date
    }
    
    func prefillData(){
        model              = AppSession.share.sATScoreModel
        dateText.text      = model.sAtDate
        rawScore.text      = model.sAtRawScore
        mathScore.text     = model.sAtMathScore
        readingScore.text  = model.sAtReadingScore
        writingScore.text  = model.sAtWritingScore
        languageScore.text = model.sAtLanguageScore
    }
    
    
    func profileUpdate(){
        if UserModel.getObject().profileCompleted == "Y"{
            let satModel            = AppSession.share.miniProfileModel.thirdStep
             model.sAtDate          = satModel.sAtExamDare
             model.sAtRawScore      = satModel.sAtRawScore
             model.sAtMathScore     = satModel.sAtMathScore
             model.sAtReadingScore   = satModel.sAtReadingScore
             model.sAtWritingScore   = satModel.sAtWritingLanguageScore
             model.sAtLanguageScore = satModel.sAtWritingLanguageScore
            AppSession.share.sATScoreModel = model
            delegate?.getSelectedSatDetails(model: model)
        }
    }
}
