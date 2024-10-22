//
//  GraduationCell.swift
//  CampusFrance
//
//  Created by Mohit on 19/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class GraduationCell: UITableViewCell {
    @IBOutlet weak var schoolName: TextInset!
    @IBOutlet weak var subjectName: TextInset!
    @IBOutlet weak var awardingBody: TextInset!
    @IBOutlet weak var yearOfPassing: TextInset!
    @IBOutlet weak var marksPercentage: TextInset!
    @IBOutlet weak var marks: TextInset!
    @IBOutlet weak var card: UIView!
    @IBOutlet var textArray: [TextInset]!
    override func awakeFromNib() {
           super.awakeFromNib()
           card.cardView()
           setUpTextFields()
       }

       
       func setUpTextFields(){
              textArray.forEach { (textField) in
                   textField.setUpView(bWidth: 1, bColor:.lightGray, rCorner: 5)
                  textField.delegate            = self
              }
          }
    
    func prefill(){
        let smodel = UserModel.getObject()
             let model              = AppSession.share.miniProfileModel
             if smodel.profileCompleted == "Y"{
            let graduation       =  model.graduationDetails
            schoolName.text      = graduation.schoolName
            subjectName.text     = graduation.subjectName
            awardingBody.text    = graduation.awardingBody
            yearOfPassing.text   = graduation.passingYear
            marksPercentage.text = graduation.marks
        }
    }

}
extension GraduationCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        switch textField.tag {
        case 0:AppSession.share.miniProfileModel.graduationDetails.schoolName    = result
        case 10:AppSession.share.miniProfileModel.graduationDetails.subjectName  = result
        case 20:AppSession.share.miniProfileModel.graduationDetails.awardingBody = result
        case 30:AppSession.share.miniProfileModel.graduationDetails.passingYear  = result
        case 40:AppSession.share.miniProfileModel.graduationDetails.marks        = result
        default:break
        }
        return true
    }
}
