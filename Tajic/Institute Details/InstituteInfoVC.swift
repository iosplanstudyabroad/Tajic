//
//  InstituteInfoVC.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteInfoVC: UIViewController {
    @IBOutlet var table: UITableView!
   
    
    
    var model = InstituteDetailsModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        self.table.rowHeight = 120
        self.table.estimatedRowHeight = UITableView.automaticDimension
        self.table.reloadData()
    }
    
    

    
    
}


extension InstituteInfoVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:if self.model.featuresArray.isEmpty {
            return 0
        }
            return CGFloat((self.model.featuresArray.count*50) + 60)
    
            case 3:if self.model.financialArray.isEmpty {
                       return 0
                   }
                return CGFloat((self.model.financialArray.count*50) + 60)
        case 4:if self.model.videoArray.isEmpty  {
            return 0
            }
            return 390
        case 5: return 170+52
        default: return UITableView.automaticDimension
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return configureInsituteCell(tableView, index: indexPath)
        case 1: return infoCell(tableView, indexPath)
        case 2: return confiureFeatureCell(indexPath, table: tableView)
        case 3:return confiureFinancialsCell(indexPath, table: tableView)
        case 4: return videoCell(tableView, index: indexPath)
        default:return socialCell(tableView, index: indexPath)
        }
    }
}

extension InstituteInfoVC {
    func configureInsituteCell(_ tabel:UITableView, index:IndexPath)-> InstituteNameDetailsCell{
        let cell = tabel.dequeueReusableCell(withIdentifier: "InstituteNameDetailsCell") as! InstituteNameDetailsCell
        cell.configure(model)
        cell.layoutIfNeeded()
        return cell
    }
    func infoCell(_ table:UITableView,_ index:IndexPath)-> InfoCell{
        let cell = table.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.configure(self.model)
        return cell
    }
    
    func confiureFeatureCell(_ index:IndexPath, table:UITableView)-> FeaturesCell{
        let cell = table.dequeueReusableCell(withIdentifier: "FeaturesCell") as! FeaturesCell
        cell.configure(self.model)
        return cell
    }
    
    
    func confiureFinancialsCell(_ index:IndexPath, table:UITableView)-> FinancialsCell{
           let cell = table.dequeueReusableCell(withIdentifier: "FinancialsCell") as! FinancialsCell
           cell.configure(self.model)
           return cell
       }
    
    func videoCell (_ tabel:UITableView, index:IndexPath)-> VideoCell{
              let cell = tabel.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
              cell.model = model
              cell.configure(with:model )
              cell.contentView.cardView()
              return cell
          }
          func socialCell (_ tabel:UITableView, index:IndexPath)-> SocialShareCell{
                 let cell = tabel.dequeueReusableCell(withIdentifier: "SocialShareCell") as! SocialShareCell
                  cell.model = model
                 return cell
             }
       
    
}
