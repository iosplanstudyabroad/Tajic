//
//  CompleteOrOngoingCell.swift
//  CampusFrance
//
//  Created by UNICA on 21/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol completeOnGoingProtocol:class {
    func completedTapped(isCompleted:String)
    func onGoingTapped(isCompleted:String)
    func enterdCourseName(courseName:String)
}
class CompleteOrOngoingCell: UITableViewCell {
    var delegate:completeOnGoingProtocol?
    @IBOutlet weak var completedTapped: UIButton!
    @IBOutlet weak var ongoingTapped: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lowerView: UIView!
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
             cardView.cardView()
              lowerView.layer.cornerRadius = 5
              lowerView.layer.masksToBounds = true
              lowerView.layer.borderColor = UIColor.darkGray.cgColor
              lowerView.layer.borderWidth = 1
              nameText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView(){
       
        
        let model = UserModel.getObject()
        if model.profileCompleted == "Y" {
            let miniModel = AppSession.share.miniProfileModel
            self.nameText.text = miniModel.firstStep.highEducationName
            if miniModel.firstStep.isCompleted.isEmpty == false{
               if miniModel.firstStep.isCompleted == "true" {
                completedTapped.setImage(radioChecked, for: .normal)
                ongoingTapped.setImage(radioUnChecked, for: .normal)
               // delegate?.completedTapped(isCompleted: "completed")
                    
               }else{
                ongoingTapped.setImage(radioChecked, for: .normal)
                completedTapped.setImage(radioUnChecked, for: .normal)
                //delegate?.onGoingTapped(isCompleted: "onging")
                }
            }
        }
        
    }
    
    @IBAction func completeBtnTapped(_ sender: Any) {
        completedTapped.setImage(radioChecked, for: .normal)
        ongoingTapped.setImage(radioUnChecked, for: .normal)
        delegate?.completedTapped(isCompleted: "completed")
    }
    
    @IBAction func onGoingBtnTapped(_ sender: Any) {
        ongoingTapped.setImage(radioChecked, for: .normal)
        completedTapped.setImage(radioUnChecked, for: .normal)
        delegate?.onGoingTapped(isCompleted: "onging")
    }
    
}


extension CompleteOrOngoingCell:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
         let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        delegate?.enterdCourseName(courseName: result)
        return true
    }
}
