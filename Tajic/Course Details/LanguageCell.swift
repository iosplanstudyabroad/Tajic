//
//  LanguageCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 21/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    @IBOutlet weak var table:UITableView!
    
    var langArray = [languageModel]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func configure(_ model:CourseDetailsModel){
        self.table.delegate   = self
        self.table.dataSource = self
        self.langArray        = model.languageRequirementArray
        self.table.reloadData()
    }
}

extension LanguageCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return configureLangCell(indexPath, tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30 
    }
}

extension LanguageCell {
    func configureLangCell(_ index:IndexPath, _ table:UITableView) -> LanguageDetailsCell {
        let cell = table.dequeueReusableCell(withIdentifier: "LanguageDetailsCell") as! LanguageDetailsCell
        cell.configure(langArray[index.row])
        return cell
    }
}
