//
//  MarketingCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol prospectDelegate {
    func getPropectDetails(model:MarketingModel)
}
class MarketingCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var table: UITableView!
    
    var marketingArray = [MarketingModel]()
    var delegate:prospectDelegate? = nil
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        self.marketingArray           = model.marketingArray
        self.table.delegate           = self
        self.table.dataSource         = self
        self.table.rowHeight          = 150
        self.table.estimatedRowHeight = UITableView.automaticDimension
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        self.layoutIfNeeded()
    }
}

extension MarketingCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func configure(_ index:IndexPath, _ table:UITableView)-> MarketingDetailsCell{
        let cell = table.dequeueReusableCell(withIdentifier: "MarketingDetailsCell") as! MarketingDetailsCell
        cell.configure(marketingArray[index.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getPropectDetails(model: marketingArray[indexPath.row])
    }
}

extension MarketingCell{
    func downloadProspect(_ prospect:String){
        if prospect.isEmpty == false && prospect.isValidURL, let url = URL(string: prospect) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
