//
//  InstituteNameCell.swift
//  CampusFrance
//
//  Created by UNICA on 13/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol InstituteNamePrtocol {
    func getEnteredText(text:String)
}
class InstituteNameCell: UITableViewCell {
   
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var istNameTxt:UITextField!
    
    var delegate:InstituteNamePrtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
        istNameTxt.delegate = self
        istNameTxt.placeholder = "Enter Institution & Awarding body"
        lowerView.border(1, borderColor: UIColor.black)
        lowerView.cornerRadius(5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ name:String){
        istNameTxt.text = name
    }

}

extension InstituteNameCell:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        delegate?.getEnteredText(text: result)
        return true
    }
}
