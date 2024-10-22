//
//  HighSchoolCell.swift
//  CampusFrance
//
//  Created by Mohit on 19/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class HighSchoolCell: UITableViewCell {
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
               
               textField.delegate            = self
           }
       }
    
    
    func prefill(){
        let smodel = UserModel.getObject()
        let model              = AppSession.share.miniProfileModel
        if smodel.profileCompleted == "Y"{
            let highSchool       =  model.highSchoolDetails
            schoolName.text      = highSchool.schoolName
            subjectName.text     = highSchool.subjectName
            awardingBody.text    = highSchool.awardingBody
            yearOfPassing.text   = highSchool.passingYear
            marksPercentage.text = highSchool.marks
        }
    }
}
extension HighSchoolCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        switch textField.tag {
        case 0:AppSession.share.miniProfileModel.highSchoolDetails.schoolName    = result
        case 10:AppSession.share.miniProfileModel.highSchoolDetails.subjectName  = result
        case 20:AppSession.share.miniProfileModel.highSchoolDetails.awardingBody = result
        case 30:AppSession.share.miniProfileModel.highSchoolDetails.passingYear  = result
        case 40:AppSession.share.miniProfileModel.highSchoolDetails.marks        = result
        default:break
        }
        return true
    }
}
