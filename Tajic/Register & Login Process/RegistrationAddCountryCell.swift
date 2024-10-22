//
//  RegistrationAddCountryCell.swift
//  Unica
//
//  Created by Mohit Kumar  on 24/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit
protocol countryUpdateProtocol {
    func countryTableUpdated()
}
class RegistrationAddCountryCell: UITableViewCell {
    @IBOutlet var countryBtn: UIButton!
    @IBOutlet var collection: UICollectionView!
    var countryArray = [CountryModel]()
    var controller = UIApplication.shared.keyWindow?.rootViewController
    var delegate:countryUpdateProtocol? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func configure(){
        countryArray = AppSession.share.multiCountryList
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.reloadData()
        countryBtn.cornerRadius(10)
    }
    
    @IBAction func countryBtnTapped(_ sender: Any){
        self.endEditing(true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
     if let vc = storyBoard.instantiateViewController(withIdentifier: "CountryListVC") as? CountryListVC {
                vc.delegate = self
                vc.isEditing = true
                if let window = UIApplication.shared.keyWindow {
                    window.rootViewController?.add(vc)
                }
            }
    }
}

extension RegistrationAddCountryCell:countryDelegate{
    func getSelectedCountry(model: CountryModel) {
        print(model.name)
    }
    
    func getCountryForStudy(model: CountryModel) {
        let countryList = AppSession.share.multiCountryList
        if countryList.count < 6 {
            
        let filter = countryList.filter{(cModel) -> Bool in
                cModel.id == model.id
            }
        
            if filter.isEmpty == false   {
            self.showAlertAfterDelay("Already added")
            }else{
            AppSession.share.multiCountryList.append(model)
               // configure()
           AppSession.share.registerModel.countryList.append(model.id)
           delegate?.countryTableUpdated()
            }
        }else{
            self.showAlertAfterDelay("Max country Aded")
        }
    }
}

extension RegistrationAddCountryCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureCell(collectionView,indexPath)
    }
    
    func configureCell(_ collection:UICollectionView,_ index:IndexPath)-> CountryCollectionCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier:"CountryCollectionCell" , for: index) as! CountryCollectionCell
        
        cell.countryName.text =  countryArray[index.item].name
        cell.close.tag = index.item
        cell.close.addTarget(self, action: #selector(removeCountryBtnTapped), for: .touchUpInside)
        cell.layoutIfNeeded()
        cell.contentView.border(1, borderColor: .lightGray)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      /*  let title = countryArray[indexPath.item].name
        let width:CGFloat = title.width(withConstrainedHeight: 50, font: UIFont.systemFont(ofSize: 19)) */
        let width = collectionView.frame.size.width/2
         return CGSize(width: width, height: 70)
       // return CGSize(width: width+25, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 1)
        //return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 10)
    }
}


extension RegistrationAddCountryCell {
    @IBAction func removeCountryBtnTapped(_ sender:UIButton){
        print("tapped Index:- , \(sender.tag)")
        AppSession.share.multiCountryList.remove(at:sender.tag)
        AppSession.share.registerModel.countryList.remove(at:sender.tag)
        configure()
        self.collection.reloadData()
        delegate?.countryTableUpdated()
    }
}


extension RegistrationAddCountryCell {
    func showAlertAfterDelay(_ msg:String){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if let root = self.controller as? UINavigationController {
                print(root.className)
                if let vc = root.viewControllers.last {
                    vc.showAlertMsg(msg: msg)
                }
            }
            if let vc = self.controller  {
                vc.showAlertMsg(msg: msg)
                
            }
        }
    }
}
