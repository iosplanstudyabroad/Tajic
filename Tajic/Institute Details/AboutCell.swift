//
//  AboutCell.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {
    @IBOutlet weak var aboutTittle:UILabel!
    @IBOutlet weak var aboutDescription:UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ model:InstituteDetailsModel, _ index:Int){
        switch index {
        case 0: aboutTittle.text = "ABOUT"
        aboutDescription.text    = model.about.htmlToString
        default:aboutTittle.text = "IMPORTANT FACTS"
        aboutDescription.text    = model.why.htmlToString
        }
    }
}
