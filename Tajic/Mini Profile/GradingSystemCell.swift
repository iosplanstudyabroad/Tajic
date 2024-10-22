//
//  GradingSystemCell.swift
//  CampusFrance
//
//  Created by UNICA on 21/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol gradingProtocol:class {
    func getGradeAndSubGrade(gradeModel:GradeModel,subGradeModel:GradeMenuModel)
}

class GradingSystemCell: UITableViewCell {
    var gradeMenuArray = [GradeModel]()
    var delegagte:gradingProtocol?
    var openMenudelegagte:gradeOpenMenuProtocol?
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var headerMenu:UILabel!
    @IBOutlet weak var headerRadio:UIImageView!
    var selectedSection = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    override func setNeedsLayout() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(){
        cardView.cardView()
        table.dataSource = self
        table.delegate = self
        
    }
    
    func reload(){
      loadFromGetProfile()
    }
    
    func loadFromGetProfile(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            if UserModel.getObject().profileCompleted == "Y" &&  self.gradeMenuArray.isEmpty == false && AppSession.share.isFirstLoad == false {
                AppSession.share.isFirstLoad = true
                for (index, value) in self.gradeMenuArray.enumerated() {
                    self.gradeMenuArray[index].isSelected = false
                    self.gradeMenuArray[index].gardeSubMenu.forEach { (GMModel) in
                        GMModel.isSelected =  false
                    }
                    if Int(self.gradeMenuArray[index].courseId) == AppSession.share.miniProfileModel.firstStep.gradeId {
                        self.openCLoseMenu(tag: index)
                        self.selectedSection = index
                        for (innerIndex, innervalue) in value.gardeSubMenu.enumerated(){
                            if Int(innervalue.gradeId) == AppSession.share.miniProfileModel.firstStep.subgradeId{
                                let button = UIButton()
                                button.tag = innerIndex
                                self.menuBtnTapped(sender: button)
                            }
                            
                        }
                    }
                   
                    
                }
            }else{
                self.table.reloadData()
            }
        }
            
        }
        
    }


extension GradingSystemCell:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
      return gradeMenuArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gradeMenuArray[section].isSelected == true {
           return gradeMenuArray[section].gardeSubMenu.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return self.nestedNormalCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return attachView(width:Double(tableView.frame.size.width) , isSelected: gradeMenuArray[section].isSelected, sectionName: gradeMenuArray[section].courseName, tag: section)
    }
    
    
    @objc func handleTap(gesture: UIGestureRecognizer)
    {
        if  let tag = gesture.view?.tag {
           openCLoseMenu(tag: tag)
        }
       
    }
   
    func openCLoseMenu(tag:Int){
        for (index, _) in gradeMenuArray.enumerated() {
            gradeMenuArray[index].isSelected = false
        }
            print("Section \(tag) Tapped")
            selectedSection = tag
            gradeMenuArray[tag].isSelected = true
            openMenudelegagte?.getTappedMenuModel(with:gradeMenuArray[tag] , selectedSection: tag)
            table.reloadData()
    }
    
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    private func nestedNormalCell(indexPath: IndexPath) -> NestedNormalCell {
        let cell            = table.dequeueReusableCell(withIdentifier: "NestedNormalCell") as!NestedNormalCell
        let model = gradeMenuArray[indexPath.section].gardeSubMenu[indexPath.row]
        cell.menuName.text  =  model.gradeName
        cell.selectionStyle = .none
        cell.menuTapped.tag = indexPath.row
        cell.menuTapped.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
      if model.isSelected {
            cell.radioBtn.setImage(radioChecked, for: .normal)
        }else{
            cell.radioBtn.setImage(radioUnChecked, for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    @objc func menuBtnTapped(sender: UIButton){
        

        
        
        for (index,_) in gradeMenuArray.enumerated(){
          for (indexx,_) in  gradeMenuArray[index].gardeSubMenu.enumerated(){
                gradeMenuArray[index].gardeSubMenu[indexx].isSelected = false
            }
            
        }
         gradeMenuArray[selectedSection].gardeSubMenu[sender.tag].isSelected = true
         let selectedModel = gradeMenuArray[selectedSection]
               delegagte?.getGradeAndSubGrade(gradeModel:selectedModel , subGradeModel: gradeMenuArray[selectedSection].gardeSubMenu[sender.tag])
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            var indexPaths = [IndexPath]()
            for (index, _) in self.gradeMenuArray[self.selectedSection].gardeSubMenu.enumerated(){
                
               let indexPath = IndexPath(row: index, section: self.selectedSection)
                indexPaths.append(indexPath)
            }
            /*(row: sender.tag, section: self.selectedSection)*
             */
            if self.gradeMenuArray.count > self.selectedSection {
               self.table.reload(tableView: self.table)//reloadRows(at: indexPaths, with: .automatic)
            }
           
        }
      //  gradeMenuArray[selectedSection].gardeSubMenu[sender.tag].isSelected = true
    }
}


extension GradingSystemCell {
    func attachView(width:Double,isSelected:Bool,sectionName:String,tag:Int)->UIView{
        let view             = UIView()
        view.frame           = CGRect(x: 0, y: 0, width: width, height: 35)
        let image            = UIImageView(frame: CGRect(x: 20, y: 7.5, width: 20, height: 20))
        image.image       = radioUnChecked
        if isSelected {
           image.image       = radioChecked
        }else{
           image.image       = radioUnChecked
        }
        let label            = UILabel(frame: CGRect(x: 50, y: 0, width: width - 45, height: 35))
        label.text           = sectionName
        label.font           = UIFont.systemFont(ofSize: 15)
        view.addSubview(image)
        view.addSubview(label)
        view.backgroundColor = UIColor.white
        view.tag             = tag
        let tapRecognizer                     = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate                = self
        tapRecognizer.numberOfTapsRequired    = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
       // view.backgroundColor = UIColor.green
        return view
    }
}


