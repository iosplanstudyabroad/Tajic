//
//  OtherQualificationCell.swift
//  CampusFrance
//
//  Created by Mohit on 19/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class OtherQualificationCell: UITableViewCell {
@IBOutlet weak var card: UIView!
    @IBOutlet weak var schoolName: TextInset!
    @IBOutlet weak var subjectName: TextInset!
    @IBOutlet weak var awardingBody: TextInset!
    @IBOutlet weak var yearOfPassing: TextInset!
    @IBOutlet weak var marksPercentage: TextInset!
    
@IBOutlet var textArray: [TextInset]!
    override func awakeFromNib() {
           super.awakeFromNib()
           card.cardView()
           setUpTextFields()
       }
       
       func setUpTextFields(){
              textArray.forEach { (textField) in
                   textField.setUpView(bWidth: 1, bColor:.lightGray, rCorner: 5)
                   textField.delegate = self
              }
          }
    
    func prefill(){
          let smodel = UserModel.getObject()
             let model              = AppSession.share.miniProfileModel
             if smodel.profileCompleted == "Y"{
                
            let otherEducation   =  model.otherEducationDetails
            schoolName.text      = otherEducation.schoolName
            subjectName.text     = otherEducation.subjectName
            awardingBody.text    = otherEducation.awardingBody
            yearOfPassing.text   = otherEducation.passingYear
            marksPercentage.text = otherEducation.marks
        }
    }

}
extension OtherQualificationCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        switch textField.tag {
        case 0:AppSession.share.miniProfileModel.otherEducationDetails.schoolName    = result
        case 10:AppSession.share.miniProfileModel.otherEducationDetails.subjectName  = result
        case 20:AppSession.share.miniProfileModel.otherEducationDetails.awardingBody = result
        case 30:AppSession.share.miniProfileModel.otherEducationDetails.passingYear  = result
        case 40:AppSession.share.miniProfileModel.otherEducationDetails.marks        = result
        default:break
        }
        return true
    }
}
