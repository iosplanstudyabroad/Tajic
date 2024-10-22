//
//  ReachUsAddressCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ReachUsAddressCell: UITableViewCell {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var mobile:UILabel!
    
    @IBOutlet var AdressName: UILabel!
    var model = BranchModel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ model:BranchModel){
        self.name.text    = model.branchType
        self.address.text = model.address
        self.AdressName.text = model.name
        self.mobile.text  = model.phoneNumber
        self.model = model
    }
    

    
    
    
    @IBAction func phoneBtnTapped(_ sender: UIButton) {
        callNumber(phoneNumber: self.model.phoneNumber)
    }
    
    private func callNumber(phoneNumber:String) {
        var number = phoneNumber.replacingOccurrences(of: "+", with: "")
             number = number.replacingOccurrences(of: " ", with: "")
      if let phoneCallURL = URL(string: "tel://\(number)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    
}
