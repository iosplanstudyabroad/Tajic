//
//  TimelineCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
@IBOutlet weak var table:UITableView!
    
     var timeLineArray = [TimeLineModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

  func configureCell(model:CourseDetailsModel){
    self.table.delegate = self
    self.table.dataSource  = self
    self.table.rowHeight = 50
    self.table.estimatedRowHeight = UITableView.automaticDimension
    self.timeLineArray = model.timeLineArray
    self.table.reloadData()
    self.layoutIfNeeded()
    }
}



extension TimelineCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.timeLineArray.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineInterNalCell") as! TimeLineInterNalCell
        cell.configure(model: self.timeLineArray[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}
