//
//  CampusInfoCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 23/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol campusProtocol {
    func calculateCampusHeight(isFirst:Bool, height:CGFloat)
}

class InstCampusInfoCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var table: UITableView!
    
    var campusInfoArray = [CampusListModel]()
    var isFirstLoad = true
    var tableViewHeight: CGFloat {
        table.layoutIfNeeded()
        return table.contentSize.height
    }
    
    var delegate:campusProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        self.campusInfoArray          = model.campusArray
        self.table.delegate           = self
        self.table.dataSource         = self
        self.table.rowHeight          = UITableView.automaticDimension
        self.table.estimatedRowHeight = UITableView.automaticDimension
        DispatchQueue.main.async {
            self.table.reloadData()
            print(self.tableViewHeight)
        }
        
     /*   if isFirstLoad {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.delegate?.calculateCampusHeight(isFirst: self.isFirstLoad, height: self.tableViewHeight)
            }
        }
        */
        self.layoutIfNeeded()
    }
}

extension InstCampusInfoCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campusInfoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func configure(_ index:IndexPath, _ table:UITableView)-> CampusInfoDetailsCell{
        let cell = table.dequeueReusableCell(withIdentifier: "CampusInfoDetailsCell") as! CampusInfoDetailsCell
        cell.configure(campusInfoArray[index.row])
        cell.layoutIfNeeded()
        return cell
    }
    
   
}




