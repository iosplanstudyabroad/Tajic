//
//  EventCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet var card: UIView!
    
    
    @IBOutlet weak var Name:UILabel!
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var time:UILabel!
    @IBOutlet weak var venue:UILabel!
    @IBOutlet weak var interestBtn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        interestBtn.setTitle("Register", for: .normal)
        
    }

    func configure(_ model:LatestEventModel){
        self.Name.text = model.eventName
        self.date.text = model.eventDate
       self.time.text = model.time
        self.venue.text = model.eventLocation
        card.cardView()
        card.cornerRadius(10)
        interestBtn.cornerRadius(interestBtn.frame.size.height/2)
        interestBtn.isUserInteractionEnabled = true
        interestBtn.setTitleColor(.white, for: .normal)
        interestBtn.setTitle("Register", for: .normal)
        if model.isRegistered {
          //  interestBtn.isUserInteractionEnabled = false
            interestBtn.setTitle("Registered", for: .normal)
            interestBtn.setTitleColor(.black, for: .normal)
        }
    }

    func setColor(hex:String){
           card.cardView()
           card.backgroundColor = UIColor().lightTheme()
        
       }
}
