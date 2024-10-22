//
//  ClickMoreCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 07/04/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

protocol clickMoreDelegate {
    func clickMoreTapped()
}
class ClickMoreCell: UITableViewCell {
    
    @IBOutlet var card: UIView!
    @IBOutlet weak var clickBtn:UIButton!
    var delegate:clickMoreDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(){
        card.cardViewWithCornerRadius(10)
        clickBtn.titleLabel?.numberOfLines = 0
        clickBtn.titleLabel?.lineBreakMode = .byWordWrapping
        clickBtn.titleLabel?.textAlignment = .center
        clickBtn.cardViewWithCornerRadius(10)
    }

    @IBAction func clickBtnTapped(_ sender:UIButton){
        delegate?.clickMoreTapped()
    }
}
