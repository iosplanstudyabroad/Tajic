//
//  EventDetailsCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 28/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class EventDetailsCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet weak var Name:UILabel!
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var time:UILabel!
    @IBOutlet weak var venue:UILabel!
    @IBOutlet weak var desc:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ model:LatestEventModel){
        self.Name.text = model.eventName
        self.date.text = model.eventDate
        self.time.text = model.time
        self.venue.text = model.eventLocation
        self.desc.text = model.desc
        card.cardView()
        card.cornerRadius(10)
    }

  
}
