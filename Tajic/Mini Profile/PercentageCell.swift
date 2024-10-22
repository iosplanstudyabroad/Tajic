//
//  PercentageCell.swift
//  CampusFrance
//
//  Created by Mohit on 20/12/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
protocol PercentageDelegate {
    func getPercentage(text:String)
}
class PercentageCell: UITableViewCell {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var textSupportView:UIView!
    @IBOutlet weak var percentText:UITextField!
    var delegate:PercentageDelegate? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
       configure()
    }
    
    func configure(){
        card.cardView()
        percentText.delegate    = self
        percentText.placeholder = "Enter exact score"
        textSupportView.border(1, borderColor: UIColor.black)
        textSupportView.cornerRadius(5)
    }
    func prefill(){
        let precent = AppSession.share.miniProfileModel.firstStep.subgradePercentage
        if  precent.isEmpty == false {
            percentText.text = String(precent)
        }
    }
}

extension PercentageCell:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        AppSession.share.miniProfileModel.firstStep.subgradePercentage = result
        return true
    }
}
