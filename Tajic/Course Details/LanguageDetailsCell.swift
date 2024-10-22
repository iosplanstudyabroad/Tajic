//
//  LanguageDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class LanguageDetailsCell: UITableViewCell {
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var value:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(_ model:languageModel){
        self.title.text = model.title
        self.value.text = model.value
    }

}
