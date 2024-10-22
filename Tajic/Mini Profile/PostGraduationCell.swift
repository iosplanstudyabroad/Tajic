//
//  PostGraduationCell.swift
//  CampusFrance
//
//  Created by Mohit on 19/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class PostGraduationCell: UITableViewCell {
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
            let postModel        =  model.postGraduationDetails
            schoolName.text      = postModel.schoolName
            subjectName.text     = postModel.subjectName
            awardingBody.text    = postModel.awardingBody
            yearOfPassing.text   = postModel.passingYear
            marksPercentage.text = postModel.marks
        }
    }
}
extension PostGraduationCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        switch textField.tag {
        case 100:AppSession.share.miniProfileModel.postGraduationDetails.schoolName    = result
        case 10:AppSession.share.miniProfileModel.postGraduationDetails.subjectName  = result
        case 20:AppSession.share.miniProfileModel.postGraduationDetails.awardingBody = result
        case 30:AppSession.share.miniProfileModel.postGraduationDetails.passingYear  = result
        case 40:AppSession.share.miniProfileModel.postGraduationDetails.marks        = result
        default:break
        }
        return true
    }
}
