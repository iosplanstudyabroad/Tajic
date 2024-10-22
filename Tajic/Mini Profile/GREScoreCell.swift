//
//  GREScoreCell.swift
//  CampusFrance
//
//  Created by UNICA on 26/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
protocol greScoreProtocol {
    func getGreAllFields(model:GreScoreModel)
}
class GREScoreCell: UITableViewCell {
    var delegate:greScoreProtocol?
    @IBOutlet weak var card: UIView!
    @IBOutlet var btnArray: [TextInset]!
    @IBOutlet weak var greDate: TextInset!
    @IBOutlet weak var greVerbal: TextInset!
    @IBOutlet weak var greVarblePercent: TextInset!
    @IBOutlet weak var quantitative: TextInset!
    @IBOutlet weak var quantitativePercent: TextInset!
    @IBOutlet weak var analyticalWriting: TextInset!
    @IBOutlet weak var analyticalWritingPercent: TextInset!
    var currentDate = Date()
    let  allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
    var model = GreScoreModel()
    var textTag  = 10
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
        setUpTextFields()
        self.selectionStyle  = .none
    }
    
    func setUpTextFields(){
        greDate.isEnabled = false
        greDate.isUserInteractionEnabled = false
        btnArray.forEach { (button) in
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            button.keyboardType =  .decimalPad
            //button.maxLength    = 6
            button.delegate = self
        
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func profileUpdate(){
        if UserModel.getObject().profileCompleted == "Y"{
            let greModel = AppSession.share.miniProfileModel.thirdStep
            model.greDate                  = greModel.greExamDate
            model.greVerbal                = greModel.greVerbalScore
            model.greVarblePercent         = greModel.greVerbal
            model.quantitative             = greModel.greQuantitativeScore
            model.quantitativePercent      = greModel.greQuantitative
            model.analyticalWriting        = greModel.greAnalyticalWritingScore
            model.analyticalWritingPercent = greModel.greAnalyticalWriting
            
            
//
//            greDate.text                 = greModel.greExamDate
//            greVerbal.text               = model.greVerbal
//            greVarblePercent.text         = model.greVarblePercent
//            quantitative.text             = model.quantitative
//            quantitativePercent.text      = model.quantitativePercent
//            analyticalWriting.text        = model.analyticalWriting
//            analyticalWritingPercent.text = model.analyticalWritingPercent
            
            
            
            AppSession.share.greScoreModel = model
            
             delegate?.getGreAllFields(model:model )
        }
    }
    
    @IBAction func dateBtnTapped(_ sender:UIButton){
        datePicker()
    }

}

extension GREScoreCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        updateModelAsPerTextField(text: result, tag: textField.tag)
        
        switch textField.tag {
        case 10,20,30,40,50,60:
            let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
                    guard !s.isEmpty else { return true }
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .none
            if let _ = numberFormatter.number(from: s)?.floatValue {
                updateModelAsPerTextField(text: s, tag: textField.tag)
            }
          return numberFormatter.number(from: s)?.floatValue != nil
        
        default:return true
        }
    }
    
    
    func updateModelAsPerTextField(text:String,tag:Int){
        guard text.isEmpty == false else {
            return
        }
        switch tag {
        case 10:model.greVerbal                = text
        case 20:model.greVarblePercent         = text
        case 30:model.quantitative             = text
        case 40:model.quantitativePercent      = text
        case 50:model.analyticalWriting        = text
        case 60:model.analyticalWritingPercent = text
        default:break
        }
        AppSession.share.greScoreModel = model
        delegate?.getGreAllFields(model:model )
    }
    
    
    func datePicker(){
        let pickerView = Bundle.main.loadNibNamed("DateSelectorView", owner: self, options: nil)![0] as?
        DateSelectorView
        pickerView?.frame = (AppDelegate.shared.window?.rootViewController?.view.frame)!
        pickerView?.delegate = self
        pickerView?.selectedDate = self.currentDate
        pickerView?.isDobValidation = false
        pickerView?.setupPickers()
        
        AppDelegate.shared.window!.rootViewController?.view.addSubview(pickerView!)
    }
    
}

extension GREScoreCell:dateProtocol{
    func selectedDate(date: Date) {
        greDate.text = ISO8601DateFormatter().convertDate(date)
        model.greDate = ISO8601DateFormatter().convertDate(date)
        self.currentDate = date
        delegate?.getGreAllFields(model:model )
    }

    
    func prefillData(){
        model                         = AppSession.share.greScoreModel
         greDate.text                 = model.greDate
         greVerbal.text               = model.greVerbal
        greVarblePercent.text         = model.greVarblePercent
        quantitative.text             = model.quantitative
        quantitativePercent.text      = model.quantitativePercent
        analyticalWriting.text        = model.analyticalWriting
        analyticalWritingPercent.text = model.analyticalWritingPercent
    }
}
