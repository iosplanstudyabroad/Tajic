//
//  SortFevtCell.swift
//  CampusFrance
//
//  Created by UNICA on 25/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit


protocol  SortFevtProtocol {
    func fevtUniversityNameTapped(with model:SearchCoursesModel)
    func fevtCourseDetailsTapped(with id:String)
}
class SortFevtCollectionCell: UICollectionViewCell {
    var delegate:SortFevtProtocol?
    var courseArray = [SearchCoursesModel]()
    var searchCourseArray = [SearchCoursesModel]()
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
    CustomSearchView
    
    var pagingCounter      = 1
    var isFetchingNextPage = false
    var isSearchEnabled    = false
    var isSearchFetchingNextPage = false
    var searchPagingCounter      = 1
    var searchKeyWord      = ""
    var nolabel = UILabel()
    
    @IBOutlet weak var table:UITableView!
    
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        addNotification()
        nolabel.frame = self.frame
        nolabel.textAlignment = .center
        nolabel.removeFromSuperview()
        self.addSubview(nolabel)
    }
    func configure(){
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        table.estimatedRowHeight = UITableView.automaticDimension
        courseArray.removeAll()
        self.getCourses(with: 1, keyword: nil)
        
    }
    
}

extension SortFevtCollectionCell {
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.getUnMatchSearchKeyword(_:)), name: NSNotification.Name(rawValue: sortNotification.fevtSearch.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: sortNotification.fevtSearchDismissed.rawValue), object: nil)
    }
    
    @IBAction  func getUnMatchSearchKeyword(_ notification: NSNotification) {
        if let dict = notification.userInfo as? [String:Any] , let keyWord = dict["key"] as? String{
            self.isSearchEnabled = true
            print(isSearchEnabled)
            self.nolabel.text = ""
            self.searchCourseArray.removeAll()
            self.table.reloadData()
            self.searchKeyWord = keyWord
            self.searchPagingCounter = 1
            self.getCourses(with: 1, keyword: keyWord)
        }
        
    }
    
    @IBAction  func dismissSearch(_ notification: NSNotification) {
        self.isSearchEnabled = false
        
        if courseArray.isEmpty == false {
            self.nolabel.text =  ""
        }
        print(isSearchEnabled)
        self.table.reloadData()
    }
}



//***********************************************//
// MARK: UItableview cell configuration
//***********************************************//
extension SortFevtCollectionCell{
    private func searchCourseCell(indexPath:IndexPath,tableView:UITableView) -> SearchCourseCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
        
        if isSearchEnabled {
            cell.configure(model: searchCourseArray[indexPath.row], isMatch: false)
            
        }else{
            cell.configure(model: courseArray[indexPath.row], isMatch: false)
        }
        
        cell.fevtBtn.tag = indexPath.row
        cell.fevtBtn.addTarget(self, action: #selector(fevtBtnTapped), for: .touchUpInside)
        cell.universityName.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
        return cell
    }
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearchEnabled {
            sendLikeDislike(sModel:self.searchCourseArray[sender.tag], index: sender.tag )
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag], index: sender.tag )
    }
    
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        var model = SearchCoursesModel()
        if isSearchEnabled {
            model = self.searchCourseArray[sender.tag]
        }else{
           model = self.courseArray[sender.tag]
        }
       
        delegate?.fevtUniversityNameTapped(with: model)
        
    }
}

//***********************************************//
// MARK: Table Delegate Methods
//***********************************************//
extension SortFevtCollectionCell:UITableViewDelegate,UITableViewDataSource
,UITableViewDataSourcePrefetching{
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isSearchEnabled {
            guard searchCourseArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.searchCourseArray.count-1 }
            if needsFetch && isSearchFetchingNextPage {
                self.getCourses(with: self.searchPagingCounter, keyword: searchKeyWord)
            }}else{
            
            guard courseArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.courseArray.count-1 }
            if needsFetch && isFetchingNextPage {
                self.getCourses(with: self.pagingCounter, keyword: nil)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchEnabled {
            return searchCourseArray.count
        }
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return searchCourseCell(indexPath:indexPath, tableView: tableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchEnabled {
           delegate?.fevtCourseDetailsTapped(with: searchCourseArray[indexPath.row].id)
            return
        }
        delegate?.fevtCourseDetailsTapped(with:courseArray[indexPath.row].id)
        }
    }




//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension SortFevtCollectionCell {
    func getCourses(with pageNumber:Int,keyword:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"page_number":pageNumber] as [String : Any]
        
        if isSearchEnabled {
            params["keyword"] = keyword
        }
        ActivityView.show()
        WebServiceManager.instance.studentSortListedCoursesWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any]{
                    if let  courseArr = data["courses"] as? [[String:Any]],courseArr.isEmpty == false{
                        courseArr.forEach({ (dict) in
                            let model = SearchCoursesModel(with: dict)
                            if self.isSearchEnabled{
                                self.searchCourseArray.append(model)
                            }else{
                                self.courseArray.append(model)
                            }
                        })
                        self.table.reloadData()
                        if self.isSearchEnabled{
                            self.isSearchFetchingNextPage = true
                            self.searchPagingCounter     += 1
                        }else{
                            self.isFetchingNextPage  = true
                            self.pagingCounter      += 1
                        }
                          self.nolabel.text = ""
                          self.table.reloadData()
                    }else{
                        
                        if self.isSearchEnabled{
                            self.isSearchFetchingNextPage = false
                        }else{
                            self.isFetchingNextPage = false
                        }
                        if let msg = json["Message"] as? String {
                            self.nolabel.text = msg
                          //  self.noRecordTest.textAlignment = .center
                          //  self.noRecordTest.text = msg
                        }
                        self.table.reloadData()
                    }
                }
                else{
                    if self.isSearchEnabled{
                        self.isSearchFetchingNextPage = false
                    }else{
                        self.isFetchingNextPage  = false
                    }
                    if let msg = json["Message"] as? String{
                        self.nolabel.text = msg
                    }
//                    self.showAlertMsg(msg: json["Message"] as! String)
                    
                }
                ActivityView.hide()
            case StatusCode.Fail:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
    
    func sendLikeDislike(sModel:SearchCoursesModel,index:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        
        
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.id,"status":"false"] as [String : Any]
        ActivityView.show()
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let _ = json["Payload"] as? [String:Any]{
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                }
                self.courseArray.remove(at: index)
                   self.table.reloadData()
                ActivityView.hide()
            case StatusCode.Fail:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    }
}
