//
//  CourseDetailsTimeLineCell.swift
//  CampusFrance
//
//  Created by UNICA on 18/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseDetailsTimeLineCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var eliglblity: UILabel!
    @IBOutlet weak var otherRequirements: UILabel!
    @IBOutlet weak var specialInstructions: UILabel!
    @IBOutlet weak var table:UITableView!
    
    @IBOutlet weak var tableHeightConst: NSLayoutConstraint!
    var model:CourseDetailsModel?
    var timeLineArray = [TimeLineModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
       self.layoutIfNeeded()
      configure()
    }

    func configure(){
        cardView.cardView()
        table.delegate = self
        table.dataSource = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(model:CourseDetailsModel){
        self.model = model
        self.timeLineArray = model.timeLineArray
        self.tableHeightConst.constant =  CGFloat(model.timeLineArray.count*50)
        table.reloadData()
        eliglblity.text = model.eligibility
        otherRequirements.text = model.otherRequirements
        specialInstructions.text = model.specialInstructions
    }

}

extension CourseDetailsTimeLineCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.timeLineArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineInterNalCell") as! TimeLineInterNalCell
        cell.configure(model: self.timeLineArray[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}
