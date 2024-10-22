//
//  UNAgentBannerCell.swift
//  Unica New
//
//  Created by UNICA on 14/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNAgentBannerCell: UITableViewCell {
    private var bannerArray = [BannerModel]()
    @IBOutlet var bannerCollection:UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!
    var timer:Timer? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ array:[BannerModel]){
        bannerCollection.cardView()
        bannerCollection.border(1, borderColor: .gray)
        self.bannerArray = array
        bannerCollection.delegate   = self
               bannerCollection.dataSource = self
               bannerCollection.contentInsetAdjustmentBehavior = .never
        bannerCollection.reloadData()
        self.pageControl.numberOfPages = array.count
    }
    
    
         func setTimer() {
              timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
         }
         var x = 1
         @objc func autoScroll() {
             
             if bannerArray.isEmpty {
                 return
             }
             
             if self.x < self.bannerArray.count {
               let indexPath = IndexPath(item: x, section: 0)
                 DispatchQueue.main.async {
                     self.bannerCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                 }
              self.pageControl.currentPage = self.x
               self.x = self.x + 1
                 
             }else{
                 if bannerArray.isEmpty {
                     return
                 }
               self.x = 0
                 self.pageControl.currentPage = self.x
                 DispatchQueue.main.async {
                     self.bannerCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
                 }
             }
         }
         
         func disableTimer(){
             self.timer?.invalidate()
             self.timer = nil
         }
          
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


extension UNAgentBannerCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgentBannerCollectionCell", for: indexPath) as! UNAgentBannerCollectionCell
        cell.configure(bannerArray[indexPath.item].showBannerUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if bannerArray[indexPath.item].openLink.isEmpty == false  {
         let link =  bannerArray[indexPath.item].openLink
            if link.isValidURL, let url = URL(string: link) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return   CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
