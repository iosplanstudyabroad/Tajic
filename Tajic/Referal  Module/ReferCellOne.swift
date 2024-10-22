//
//  ReferCellOne.swift
//  unitree
//
//  Created by Mohit Kumar  on 17/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReferCellOne: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var nameView: UIView!
    @IBOutlet var name: UITextField!
    @IBOutlet var emailView: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var phoneView: UIView!
    @IBOutlet var phone: UITextField!
    @IBOutlet var removeBtn: UIButton!
    @IBOutlet var addMoreBtn: UIButton!
    var delegate:ReferDelegate? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configure(_ index:IndexPath){
        card.cardView()
        nameView.border(1, borderColor: .darkGray)
        nameView.cornerRadius(10)
        emailView.border(1, borderColor: .darkGray)
        emailView.cornerRadius(10)
        phoneView.border(1, borderColor: .darkGray)
        phoneView.cornerRadius(10)
        removeBtn.tag = index.section
        addMoreBtn.tag = index.section
    }
   @IBAction func removeBtnTapped(_ sender:UIButton){
    delegate?.removeTapAt(index: sender.tag)
   }
    @IBAction func addMoreBtnTapped(_ sender:UIButton){
        delegate?.addMoreTapAt(index: sender.tag)
    }
    func clear(){
        name.text = ""
        email.text = ""
        phone.text = ""
    }

}

extension ReferCellOne:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        switch textField.tag {
        case 10:delegate?.getName(name: result, index: addMoreBtn.tag)
        case 20:delegate?.getemail(name: result, index: addMoreBtn.tag)
        case 30:delegate?.getMobile(name: result, index: addMoreBtn.tag)
        default:break
        }
        return true
    }
}
