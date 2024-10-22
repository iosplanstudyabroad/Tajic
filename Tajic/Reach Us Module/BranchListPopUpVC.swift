//
//  BranchListPopUpVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 23/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

protocol BranchDelegate {
    func getSelectedBranch(index:Int)
}
class BranchListPopUpVC: UIViewController {
    @IBOutlet weak var card:UIView!
    @IBOutlet weak var table:UITableView!
    var branchArray = [BranchModel]()
    var selectedIndex = 0
    
    var delegate:BranchDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    func configure(){
        self.table.rowHeight = 50
        self.table.estimatedRowHeight = UITableView.automaticDimension
        self.table.reloadData()
        card.cardView()
        card.cornerRadius(10)
    }
    @IBAction func closeBtnTapped(_ sender:UIButton){
        self.remove()
    }

}

extension BranchListPopUpVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return configureCell(tableView, indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            self.remove()
        }
        delegate?.getSelectedBranch(index: indexPath.row)
    }
    
    func configureCell(_ table:UITableView,_ index:IndexPath)-> BranchListPopUpCell {
        let cell = table.dequeueReusableCell(withIdentifier: "BranchListPopUpCell") as! BranchListPopUpCell
        cell.configure(self.branchArray[index.row].name, isSelected: index.row == self.selectedIndex)
        cell.layoutIfNeeded()
        cell.card.cardView()
        cell.card.cornerRadius(10)
        return cell
    }
}
