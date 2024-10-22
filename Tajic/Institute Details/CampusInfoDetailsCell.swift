//
//  CampusInfoDetailsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 23/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CampusInfoDetailsCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model:CampusListModel){
        self.layoutIfNeeded()
        self.title.text = model.title
        self.desc.text = model.desc
        self.card.cardView()

        self.layoutIfNeeded()
    }
}
