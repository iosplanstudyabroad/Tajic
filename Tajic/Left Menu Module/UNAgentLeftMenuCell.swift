//
//  UNAgentLeftMenuCell.swift
//  Unica New
//
//  Created by Mohit Kumar on 07/09/19.
//  Copyright © 2019 Mohit Kumar. All rights reserved.
//

import UIKit
import SDWebImage

protocol subMenuProtocol {
    func getSelectedSubModel(model:SubMenuModel)
}

class UNAgentLeftMenuCell: UITableViewCell {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var menuName:UILabel!
    @IBOutlet weak var menuImage:UIImageView!
   private var subMenuArray = [SubMenuModel]()
    var delegate:subMenuProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initial()
    }

    func initial(){
      //  table.delegate = self
       // table.dataSource = self
    }
    
    
    func configure(model:MenuModel, isSelected:Bool){
        
       // card.newCardView()
        if let url = URL(string:model.leftMenuIconUrl){
           menuImage.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
            if let image = menuImage.image {
             let coloredImg =    image.withColor(UIColor.white)
               menuImage.image = coloredImg
            }
          
            
        }
        menuName.text = model.leftMenuTitle
        menuName.textColor = UIColor.white
        card.backgroundColor = UIColor.clear
        if isSelected {
            self.card.backgroundColor = UIColor().hexStringToUIColor(hex: "#FE9901")
        }
    }
}

extension   UNAgentLeftMenuCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subMenuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentsubMenuCell")as! UNAgentsubMenuCell
        cell.configure(subMenuArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = subMenuArray[indexPath.row]
        delegate?.getSelectedSubModel(model:model )
    }
}


extension UIImage {
    func withColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
        color.setFill()
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: CGRect(x: 0, y: 0, width: size.width, height: size.height), mask: cgImage)
        ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return colored
    }
}
