//
//  CourseDetailsLowerCell.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class CourseDetailsLowerCell: UITableViewCell {
var model = CourseDetailsModel()
    @IBOutlet weak var table:UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        basicConfigure()
    }
    
    var numberOfRows = 3
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func basicConfigure(){
        table.layer.borderWidth = 0.5
        table.layer.borderColor = UIColor.lightGray.cgColor
    }
    func configureCell(model:CourseDetailsModel){
        self.model = model
//        if model.courseIntakeArray.isEmpty {
//           numberOfRows = 2
//        }else{
//           numberOfRows = 3
//        }
        table.reloadData()
        
    }
}


extension CourseDetailsLowerCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return CourseLowerDescritpionCell(indexPath:indexPath, tableView: tableView)
        case 1: return CourseLowerDetailsCell(indexPath:indexPath, tableView: tableView)
        default:return CourseLowerIntakeCell(indexPath:indexPath, tableView: tableView)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: if self.model.descriptionRowHeight < 80 {
             return 100
        }
            
            return self.model.descriptionRowHeight+10
        case 1:
            return 266
        default:
            print(model.intakeHeight)
            return calculateHeigt()
        }
    }
    
    
    func calculateHeigt()-> CGFloat{
     let height =    57 + model.courseIntakeArray.count*50
     return  CGFloat(height)
    }
}

extension CourseDetailsLowerCell{
    private func CourseLowerDescritpionCell(indexPath:IndexPath,tableView:UITableView) -> CourseLowerDescritpionCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseLowerDescritpionCell") as! CourseLowerDescritpionCell
       cell.configureCell(model: self.model)
        cell.selectionStyle = .none
        return cell
    }
    
    private func CourseLowerDetailsCell(indexPath:IndexPath,tableView:UITableView) -> CourseLowerDetailsCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseLowerDetailsCell") as! CourseLowerDetailsCell
        cell.configureCell(model: self.model)
        cell.selectionStyle = .none
        return cell
    }
    
    private func CourseLowerIntakeCell(indexPath:IndexPath,tableView:UITableView) -> CourseLowerIntakeCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseLowerIntakeCell") as! CourseLowerIntakeCell
        cell.configureCell(model:self.model)
        cell.selectionStyle = .none
        return cell
    }
    @IBAction func fevtBtnTapped(_ sender: UIButton) {}
    @IBAction func selectBtnTapped(_ sender: UIButton) {}
}
