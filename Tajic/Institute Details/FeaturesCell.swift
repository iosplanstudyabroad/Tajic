//
//  FeaturesCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 22/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class FeaturesCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var table: UITableView!
    
    var featureList = [FeaturesModel]()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(_ model:InstituteDetailsModel){
        card.cardView()
        self.featureList      = model.featuresArray
        self.table.delegate   = self
        self.table.dataSource = self
        self.table.reloadData()
        self.layoutIfNeeded()
    }
}

extension FeaturesCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func configure(_ index:IndexPath, _ table:UITableView)-> FeaturesDetailsCell{
        let cell = table.dequeueReusableCell(withIdentifier: "FeaturesDetailsCell") as! FeaturesDetailsCell
        cell.configure(featureList[index.row])
        cell.layoutIfNeeded()
        return cell
    }
    
}
