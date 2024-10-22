//
//  ChargeModel.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class ChargeModel: NSObject {
    var tutionFee            = ""
    var livingCost           = ""
    var domesticStdTutionFee = ""
    var addtionalFeeAndNotes = ""
    var tutionFeeBreakup     = ""
    var appFee    = ""
    convenience init(with data:[String:Any]) {
        self.init()
        if let tutionFee              = data["tution_fee"] as? String{
            self.tutionFee            = tutionFee
        }
        if let livingCost             = data["living_cost"] as? String{
            self.livingCost           = livingCost
        }
        if let domesticStdTutionFee   = data["domestic_std_tution_fee"] as? String{
            self.domesticStdTutionFee = domesticStdTutionFee
        }
        if let addtionalFeeAndNotes   = data["addtional_fee_and_notes"] as? String{
            self.addtionalFeeAndNotes = addtionalFeeAndNotes
        }
        
        if let tutionFeeBreakup       = data["tution_fee_breakup"] as? String{
            self.tutionFeeBreakup     = tutionFeeBreakup
        }
        
        if let appFee = data["application_fee"] as? String{
            self.appFee = appFee
        }
    
    }
}


/*
 {
 "tution_fee": "3600 USD",
 "living_cost": "6000 USD",
 "domestic_std_tution_fee": "",
 "addtional_fee_and_notes": " 100  USD",
 "tution_fee_breakup": ""
 }
 
 
 "addtional_fee_and_notes" = "   EUR";
 "application_fee" = 0;
 "domestic_std_tution_fee" = "";
 "living_cost" = "166667 EUR";
 "tution_fee" = "50000000 EUR";
 "tution_fee_breakup" = "";
 
 */
