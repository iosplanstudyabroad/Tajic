//
//  IntakeCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class IntakeCell: UITableViewCell {
    @IBOutlet weak var table:UITableView!
    
    var intakeArray = [CourseIntakeModel]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      self.table.delegate   = self
             self.table.dataSource = self
    }

    func configure(_ model:CourseDetailsModel){
       
        self.intakeArray        = model.courseIntakeArray
        self.table.reloadData()
    }
}

extension IntakeCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intakeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return configureIntakeCell(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension IntakeCell {
    func configureIntakeCell(_ index:IndexPath, _ table:UITableView) -> IntakeDetailsCell {
        let cell = table.dequeueReusableCell(withIdentifier: "IntakeDetailsCell") as! IntakeDetailsCell
        cell.configure(intakeArray[index.row])
        return cell
    }
}

