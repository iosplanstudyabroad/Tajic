//
//  AccreditationCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 19/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class AccreditationCell: UITableViewCell {
   // @IBOutlet var card: UIView!
    @IBOutlet private weak var collection: UICollectionView!

     var accreditationArray = [String]()
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    //#D7E8FA Ravi
   //7a90b8
    // old #6C8CC7
    func initialSetup(){
        self.layoutIfNeeded()
        collection.delegate = self
        collection.dataSource = self

    }
    func configure(model:CourseDetailsModel){
        accreditationArray = model.accreditationArray
        DispatchQueue.main.async {
            self.initialSetup()
         self.collection.reloadData()
        }
    }
}






extension AccreditationCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accreditationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureCell(collectionView, index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width - 10
        let size  = CGSize(width: width/3.0, height: 122)
        return size
    }
    
    func configureCell(_ collection:UICollectionView,index:IndexPath)-> AccreditationCollectionCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "AccreditationCollectionCell", for: index) as! AccreditationCollectionCell
        cell.configure(accreditationArray[index.item])
        cell.layoutIfNeeded()
        return cell
    }
}

