//
//  NestedNormalCell.swift
//  CampusFrance
//
//  Created by UNICA on 21/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import RxSwift
import  Foundation

protocol gradeOpenMenuProtocol:class{
    func getTappedMenuModel(with  model:GradeModel, selectedSection:Int)
}
class NestedNormalCell: UITableViewCell {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var menuName: UILabel!
    var gradeMenuModel:GradeModel!
    var delegate:gradeOpenMenuProtocol?
    var isShowMenu = false
    @IBOutlet weak var menuTapped: UIButton!
     @IBOutlet weak var radioBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    //   menuTapped.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    
    
}


extension NestedNormalCell{
    
    
    
//    @objc func menuBtnTapped(_ sender: UIButton) {
//        
//       
//    }
  
}
 
