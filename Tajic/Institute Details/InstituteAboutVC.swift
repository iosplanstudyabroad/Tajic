//
//  InstituteAboutVC.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteAboutVC: UIViewController{
    @IBOutlet var table: UITableView!
  
    var model = InstituteDetailsModel()
     var isFirstLoad = true
    var  campusHeight:CGFloat = 0.0
    var campusCell: InstCampusInfoCell? = nil
    var marketCell:MarketingCell? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.isFirstLoad = false
            self.table.reloadData()
        }
    }
}
extension InstituteAboutVC:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 3
        default:return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return  UITableView.automaticDimension
        case 1: if self.model.about.isEmpty && self.model.why.isEmpty {
            return 0
        }
            return  UITableView.automaticDimension
        case 2: switch indexPath.row {
        case 0:if self.model.marketingArray.isEmpty {
            return 0
        }
            if let cell = marketCell {
            let height = cell.table.contentSize.height
             return height + 50
        }else{
            return 0
        }
        
        case 1:return UITableView.automaticDimension
        case 2:if self.model.campusArray.isEmpty {
                return 0
            }
            if  let cell   = campusCell {
                let height = cell.table.contentSize.height
                 return height + 60
            }else{
                return 0
            }
        default: return UITableView.automaticDimension
            }
        default: return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:return configureInsituteCell(tableView,  indexPath)
        case 1:return aboutCell(tableView, indexPath)
        case 2: switch indexPath.row {
        case 0:return configureMarketingCell(tableView, indexPath)
        case 1: return configureContactInfoCell(tableView, indexPath)
        case 2: return configureInstCampusInfoCell(tableView, indexPath)
        default:return configureMarketingCell(tableView, indexPath)
            }
        default:return configureMarketingCell(tableView, indexPath)
        }
    }
}

extension InstituteAboutVC:campusProtocol,prospectDelegate {
    
    func getPropectDetails(model: MarketingModel) {
        self.commonWeb(model: model)
    }
    
    func calculateCampusHeight(isFirst: Bool, height: CGFloat) {
        self.campusHeight = height + 50
        self.table.reloadData()
    }
    
    
    func commonWeb(model:MarketingModel){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
            vc.titleString = model.title
            vc.urlString = model.prospectus
            vc.isDownloadEnable = true
            nav.pushViewController(vc, animated: true)
            
           // AppDelegate.shared.window?.rootViewController?.add(vc)
            }}
        
    }
    
}
extension InstituteAboutVC {
    func configureInsituteCell(_ tabel:UITableView,_  index:IndexPath)-> InstituteNameDetailsCell{
        let cell = tabel.dequeueReusableCell(withIdentifier: "InstituteNameDetailsCell") as! InstituteNameDetailsCell
        cell.configure(model)
        table.separatorStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    func aboutCell(_ table:UITableView,_ index:IndexPath)-> AboutCell{
        let cell = table.dequeueReusableCell(withIdentifier: "AboutCell") as! AboutCell
        table.separatorStyle = .singleLine
        cell.configure(self.model, index.row)
        return cell
    }
    
    
    func configureMarketingCell(_ tabel:UITableView,_ index:IndexPath)-> MarketingCell{
        table.separatorStyle = .none
        let cell = tabel.dequeueReusableCell(withIdentifier: "MarketingCell") as! MarketingCell
        cell.configure(model)
        self.marketCell = cell
        cell.delegate = self
        cell.layoutIfNeeded()
        return cell
    }
    
    
   //ContactInformationCell
    
    
    func configureContactInfoCell(_ tabel:UITableView,_ index:IndexPath)-> ContactInformationCell{
           table.separatorStyle = .none
           let cell = tabel.dequeueReusableCell(withIdentifier: "ContactInformationCell") as! ContactInformationCell
        
           cell.configure(model)
           
           cell.layoutIfNeeded()
           return cell
       }
    
    
    
    
    func configureInstCampusInfoCell(_ tabel:UITableView,_ index:IndexPath)-> InstCampusInfoCell{
           table.separatorStyle = .none
           let cell = tabel.dequeueReusableCell(withIdentifier: "InstCampusInfoCell") as! InstCampusInfoCell
        cell.delegate = self
        cell.isFirstLoad = self.isFirstLoad
        self.campusCell = cell
           cell.configure(model)
           cell.layoutIfNeeded()
           return cell
       }
    
    
    
    
}


/*{
    @IBOutlet weak var table:UITableView!
    @IBOutlet var card: UIView!
       @IBOutlet var instImage: UIImageView!
    var model = InstituteDetailsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure(){
        card.cardView()
        self.setImage(imageURL: model.image)
        DispatchQueue.main.async {
            self.table.cardViewWithCornerRadius(5)
        }
    }
    
    func setImage(imageURL:String){
        if imageURL.isEmpty == false && imageURL.isValidURL == true, let url = URL(string:imageURL ) {
            self.instImage.sd_setImage(with:url , completed: nil)
        }
    }
   
}
extension InstituteAboutVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return aboutCell(tableView,indexPath)
    }
}

extension InstituteAboutVC {
    func aboutCell(_ table:UITableView,_ index:IndexPath)-> AboutCell{
        let cell = table.dequeueReusableCell(withIdentifier: "AboutCell") as! AboutCell
        cell.configure(self.model, index.row)
        return cell
    }
    
   
}
*/
