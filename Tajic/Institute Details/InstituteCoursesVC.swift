//
//  InstituteCoursesVC.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteCoursesVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    var model                    = InstituteDetailsModel()
    var courseArry               = [CourseModel]()
    var isFromFeature            = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure(){
        self.view.layoutIfNeeded()
        table.estimatedRowHeight = 120
       table.rowHeight        =  UITableView.automaticDimension
        getCourseList(sortType:"0")
    }
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        if sender.currentTitle == "Low to Heigh" {
            sender.setTitle("Heigh to Low", for: .normal)
            getCourseList(sortType: "1")
            return
        }
        
        if sender.currentTitle == "Heigh to Low"{
           sender.setTitle("Low to Heigh", for: .normal)
            getCourseList(sortType: "0")
             return
        }
    }
    
   
    func getCourseList(sortType:String){
    let instModel                = InstituteViewModel()
        if isFromFeature {
            instModel.featureinstituteCourses(1,sortType,self.model.id) { (courseArr ) in
                if courseArr.isEmpty == false {
                    self.courseArry  = courseArr
                    self.table.reloadData()
                }
            }
        }else{
            instModel.instituteCourses(1,sortType,self.model.id) { (courseArr ) in
                if courseArr.isEmpty == false {
                    self.courseArry  = courseArr
                    self.table.reloadData()
                }
            }
        }
        
        
    }
}
//***********************************************//
// MARK: UItable view Defined Here 
//***********************************************//

extension InstituteCoursesVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return courseCell(tableView, cellForRowAt: indexPath)
    }
    func courseCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> CourseCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as! CourseCell
        cell.configure(model:courseArry[indexPath.row] )
        
        return cell
    }
}
