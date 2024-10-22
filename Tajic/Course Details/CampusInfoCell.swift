//
//  CampusInfoCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 20/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class CampusInfoCell: UITableViewCell {
    @IBOutlet var table: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(){
        self.table.dataSource = self
        self.table.delegate = self
    }
}

extension CampusInfoCell:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureInformationCell(indexPath, tableView)
    }
    
    
}
extension CampusInfoCell{
    func configureInformationCell(_ index:IndexPath,_ table:UITableView)-> CampusListCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CampusListCell") as! CampusListCell
        return cell
    }
}
