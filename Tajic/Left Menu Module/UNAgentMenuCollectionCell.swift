//
//  UNAgentMenuCollectionCell.swift
//  Unica New
//
//  Created by UNICA on 16/09/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNAgentMenuCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var card:UIView!
    @IBOutlet private weak var supportView:UIView!
    @IBOutlet private weak var titleLbl:UILabel!
    @IBOutlet private weak var iconImage:UIImageView!
    
    override func awakeFromNib() {
       
    }
    
    func configureCards(_ index:Int){
         DispatchQueue.main.asyncAfter(deadline: .now()) {
            //self.card.cardView()
            self.card.cardViewWithCornerRadius(10)
            //self.card.border(1, borderColor:.darkGray)
           }
    }
    
   
    func configure(_ model:MenuModel,index:Int){
        print("Selected Section :- \(model.rowNumber),\(index)")
        self.configureCards(index)
        let urlStr = model.dashBoardIconUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if  let logo = urlStr, let url = URL(string:logo) {
           iconImage.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
          //  iconImage.sd_setImage(with: url) { (img, erro, type, newUrl) in
          /*      guard let icnImage = img else{
                    return
                }
               self.iconImage.image = icnImage
            */
                //self.iconImage.image = self.iconImage.image?.withRenderingMode(.alwaysTemplate)
                let color = UIColor().hexStringToUIColor(hex: "BC1773")
              //  self.iconImage.tintColor = color//.white
            }
        
        //titleLbl.sizeToFit()
    
        titleLbl.text      = model.leftMenuTitle
    
    //.uppercased() //+ " \(index)"
    
        titleLbl.font      = UIFont.systemFont(ofSize: 12.0)
        titleLbl.textColor = .black
        print(UIScreen.main.bounds.height)
        if UIScreen.main.bounds.height == 667 {
            titleLbl.font  = UIFont.systemFont(ofSize: 11.0)
        }
        if   UIScreen.main.bounds.width == 428{
            titleLbl.font  = UIFont.systemFont(ofSize: 12.0)
        }
    }
    
    
    func setColor(hex:String){
       /// self.card.backgroundColor = UIColor().hexStringToUIColor(hex: hex)
        
    }
}
