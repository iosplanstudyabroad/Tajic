//
//  InstituteVideoVC.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteVideoVC: UIViewController {
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
extension InstituteVideoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return videoCell(tableView, index: indexPath)
        default:return socialCell(tableView, index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return 390
        default:return 170
        }
    }
}
extension InstituteVideoVC {
    func videoCell (_ tabel:UITableView, index:IndexPath)-> VideoCell{
        let cell = tabel.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.model = model
        cell.configure(with:model )
        return cell
    }
    func socialCell (_ tabel:UITableView, index:IndexPath)-> SocialShareCell{
           let cell = tabel.dequeueReusableCell(withIdentifier: "SocialShareCell") as! SocialShareCell
         cell.model = model
        
           return cell
       }
}
