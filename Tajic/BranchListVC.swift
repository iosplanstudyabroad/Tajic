//
//  BranchListVC.swift
//  Tajic
//
//  Created by Mohit Kumar  on 07/03/22.
//  Copyright © 2022 Unica Solutions. All rights reserved.
//

import UIKit

class BranchListVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    var branchList = [BranchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        
    }
}

extension  BranchListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView, indexPath)
    }
}


extension BranchListVC {
    func configureCell(_ table:UITableView,_ index:IndexPath)-> BranchListPopUpCell {
        let cell = table.dequeueReusableCell(withIdentifier: "BranchListPopUpCell")as! BranchListPopUpCell
        return cell
    }
}
