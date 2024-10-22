//
//  CountryView.swift
//  CampusFrance
//
//  Created by UNICA on 17/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol countryProtocol {
    func selectedCountryDetails(model:CountryModel)
}
protocol instituteDelegate {
    func selectedInstituteDetails(model:CountryModel)
}

class CountryView: UIView {

    @IBOutlet weak var table: UITableView!
    var countryArray = [CountryModel]()
    var delegate:countryProtocol?
    var instDelegate:instituteDelegate?
    
  override  func awakeFromNib() {
        print("Hello")
    }

    func configureTableView(){
        let nib = UINib(nibName: "CountryTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CountryTableCell")
        table.reloadData()
    }
}



extension CountryView:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableCell") as! CountryTableCell
        cell.countryName.text = countryArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.removeFromSuperview()
            countryArray.removeAll()
            table.reloadData()
        }
       delegate?.selectedCountryDetails(model:countryArray[indexPath.row])
        if let del = instDelegate {
            del.selectedInstituteDetails(model:countryArray[indexPath.row] )
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        setBackGroundColor(tableView.cellForRow(at: indexPath)!, color: UIColor().themeColor())
    }
    
    func setBackGroundColor(_ cell: UITableViewCell,color:UIColor){
        cell.contentView.backgroundColor = color
    }
}
