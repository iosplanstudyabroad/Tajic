//
//  ScoreCell.swift
//  CampusFrance
//
//  Created by UNICA on 25/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {
 @IBOutlet weak var validRadioImage: UIImageView!
    
    @IBOutlet weak var menuLabl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(model:ExamScoreSubModel){
        menuLabl.text = model.title + " - " + model.value
        setRadio(isClicked:model.isSelected)
    }
    
    func setRadio(isClicked:Bool){
        if isClicked {
            validRadioImage.image = radioChecked
        }else{
            validRadioImage.image = radioUnChecked
        }
    }

}
