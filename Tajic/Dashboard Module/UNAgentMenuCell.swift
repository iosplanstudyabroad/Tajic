//
//  UNAgentMenuCell.swift
//  Unica New
//
//  Created by UNICA on 14/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
protocol agentMenuProtocol {
    func getTappedMenuDetails(model:MenuModel)
}
class UNAgentMenuCell: UITableViewCell {
    @IBOutlet private weak var eventBack: UIView!
    @IBOutlet private weak var eventSupportView: UIView!
    @IBOutlet  private weak var eventNameLabl: UILabel!
    
    @IBOutlet var menuCollection: UICollectionView!
    var backGroundColorArray = [
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D"]

    var delegate:agentMenuProtocol?
   private var menuArray = [MenuModel]()
   var  eventArray  = [commonModel] ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       initialSetup()
    }
    /*
     Green Color   #48B941

     Blue Color   #3762A5

     Yellow    #F7A400
     */
    func initialSetup(){
        menuCollection.delegate = self
        menuCollection.dataSource = self
        DispatchQueue.main.async {
           // self.eventSupportView.cornerRadius(10)
           // self.eventBack.roundCorners([.bottomLeft,.topLeft], radius: 10)
        }
    }
    func configure(_ menuArray:[MenuModel],_ eventArray:[commonModel]?){
        if let evnt = eventArray {
            self.eventArray  = evnt
        }
        self.menuArray = menuArray
       self.menuCollection.isScrollEnabled = false
     self.menuCollection.reloadData()
    }
    @IBAction func chooseEventBtnTapped(_ sender: UIButton) {}
}

extension UNAgentMenuCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  6 //menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgentMenuCollectionCell", for: indexPath) as! UNAgentMenuCollectionCell
        cell.configure(menuArray[indexPath.row],index: indexPath.row)
        
   // cell.setColor(hex: backGroundColorArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let itemCount = indexPath.item+1
        if menuArray.count == itemCount && menuArray.count%3 != 0  {
            let width = collectionView.frame.size.width - 10
            let size = CGSize(width: width, height: 100)
            return size
        }else {
            let width = collectionView.frame.size.width - 10
            let size = CGSize(width: width/3, height: 100)
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.getTappedMenuDetails(model: menuArray[indexPath.item])
    }
}
