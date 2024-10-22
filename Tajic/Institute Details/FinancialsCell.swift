//
//  FinancialsCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class FinancialsCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var table: UITableView!
    
    var financialList = [FinancialModel]()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        self.financialList      = model.financialArray
        self.table.delegate   = self
        self.table.dataSource = self
        self.table.reloadData()
        self.layoutIfNeeded()
    }
}

extension FinancialsCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return financialList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func configure(_ index:IndexPath, _ table:UITableView)-> FinancialsDetailsCell{
        let cell = table.dequeueReusableCell(withIdentifier: "FinancialsDetailsCell") as! FinancialsDetailsCell
        cell.configure(financialList[index.row])
        cell.layoutIfNeeded()
        return cell
    }
    
}

