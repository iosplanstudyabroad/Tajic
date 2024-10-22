//
//  MatchedCollectionCell.swift
//  CampusFrance
//
//  Created by UNICA on 19/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//


import UIKit



protocol  MatchedProtocol {
    func matchedUniversityNameTapped(with model:SearchCoursesModel)
    func matchedCourseDetailsTapped(with model:SearchCoursesModel)
}

class MatchedCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var noRecordLabl: UILabel!
    @IBOutlet weak var table:UITableView!
    var courseArray = [SearchCoursesModel]()
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var delegate:MatchedProtocol?
    
    var isSearching = false
    
    var searchCourseArray = [SearchCoursesModel]()
    private var isSearchFetchingNextPage = false
    var searchPagingCounter              = 1
    var keyword               = ""
    
    func configure(){
        self.table.delegate           = self
        self.table.dataSource         = self
        self.table.prefetchDataSource = self
        table.rowHeight               = 150
        table.estimatedRowHeight      = UITableView.automaticDimension
        courseArray.removeAll()
        self.getCourses(with: 1, keyword: nil)
        addNotification()
    }
    
    
    //"matchSearch"
}

extension MatchedCollectionCell {
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMatchSearchKeyword(_:)), name: NSNotification.Name(rawValue: "matchSearch"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil)
        //Dismissed
    }
    
    
    // handle notification
    @IBAction  func getMatchSearchKeyword(_ notification: NSNotification) {
        if  let info = notification.userInfo as? [String:Any], let keyword = info["key"] as? String {
            self.isSearching = true
            self.searchCourseArray.removeAll()
            self.isSearchFetchingNextPage = false
            self.searchPagingCounter = 1
            self.table.reloadData()
            self.getCourses(with: 1, keyword: keyword)
            self.keyword = keyword
        }
    }
   
    @IBAction  func dismissSearch(_ notification: NSNotification) {
        self.isSearching = false
        self.isFetchingNextPage = false
        self.pagingCounter = 1
        self.table.reloadData()
        self.getCourses(with: 1, keyword: nil)
    }
}


//***********************************************//
// MARK: UITable Methods
//***********************************************//
extension MatchedCollectionCell:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isSearching {
            guard searchCourseArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.searchCourseArray.count-1 }
            if needsFetch && isSearchFetchingNextPage {
                self.getCourses(with: self.pagingCounter, keyword: self.keyword)
            }
            return
        }
        
        guard courseArray.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.courseArray.count-1 }
        if needsFetch && isFetchingNextPage {
            self.getCourses(with: self.pagingCounter, keyword:nil )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
             return searchCourseArray.count
        }
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return searchCourseCell(indexPath:indexPath, tableView: tableView)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if isSearching{
                 let model = searchCourseArray[indexPath.row]
                           
                            model.isShowCourse = true
            
            
            delegate?.matchedUniversityNameTapped(with:model)
                  return
              }
        
            
        
       let model = courseArray[indexPath.row]
                                  
            model.isShowCourse = true
            delegate?.matchedUniversityNameTapped(with:model)
        
        
//        if isSearching{
//
//            let model = searchCourseArray[indexPath.row]
//
//            model.isShowCourse = true
//            //delegate?.matchedCourseDetailsTapped(with:searchCourseArray[indexPath.row].courseId)
//            return
//        }
//        delegate?.matchedCourseDetailsTapped(with:courseArray[indexPath.row].courseId)
    }
}





extension MatchedCollectionCell {
    
    private func searchCourseCell(indexPath:IndexPath,tableView:UITableView) -> SearchCourseCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
        if isSearching{
             cell.configure(model: searchCourseArray[indexPath.row],isMatch: true)
        }else{
        cell.configure(model: courseArray[indexPath.row],isMatch: true)
        }
       
        cell.fevtBtn.tag = indexPath.row
        cell.fevtBtn.addTarget(self, action: #selector(fevtBtnTapped), for: .touchUpInside)
        cell.universityName.tag = indexPath.row
        cell.universityName.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
        cell.univeristyImageBtn.tag = indexPath.row
        cell.univeristyImageBtn.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
        
        cell.card.cardViewWithCornerRadius(10)
        cell.InsImage.cardViewWithCircle()
        return cell
    }
    
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearching{
            sendLikeDislike(sModel:self.searchCourseArray[sender.tag], selectedIndex: sender.tag )
           
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag], selectedIndex: sender.tag )
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        if isSearching{
            let model = self.searchCourseArray[sender.tag]
            model.isShowCourse =  false
            delegate?.matchedUniversityNameTapped(with: model )
            return
        }
        let model = self.courseArray[sender.tag]
        model.isShowCourse =  false
        delegate?.matchedUniversityNameTapped(with:model)
    }
    
}





//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension MatchedCollectionCell {
    func getCourses(with index:Int,keyword:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"page_number":index,"match_course_hide": "N"] as [String : Any]
        
        if self.isSearching{
            params["keyword"] =  keyword
        }
        WebServiceManager.instance.getSearchMatchedCoursesStatusWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                 ActivityView.hide()
                if let code = json["Code"] as? Int, code == 404 && index == 1 {
                    if self.isSearching {
                        self.searchCourseArray.removeAll()
                    }else{
                        self.courseArray.removeAll()
                    }
                    
                    self.noRecordLabl.text = "No Records found"
                    
                    self.table.reloadData()
                    return
                }
                if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]]{
                    if let msg = json["Message"] as? String, msg ==  "No Records found" {
                        
                        if self.isSearching{
                            if  self.searchPagingCounter == 1 {
                                self.noRecordLabl.text = "No Records found"
                            }
                           self.isSearchFetchingNextPage = false
                             self.table.reloadData()
                            return
                        }
                         self.isFetchingNextPage = false
                        if  self.pagingCounter == 1 {
                            self.noRecordLabl.text = "No Records found"
                            
                        }
                         self.table.reloadData()
                        return
                    }
                    courseArr.forEach({ (dict) in
                        let model = SearchCoursesModel(with: dict)
                        if self.isSearching{
                            self.searchCourseArray.append(model)
                        }else{
                         self.courseArray.append(model)
                        }
                    })
                    
                    if self.isSearching{
                     self.searchPagingCounter += 1
                        self.isSearchFetchingNextPage = true
                    }else{
                        self.pagingCounter += 1
                        self.isFetchingNextPage = true
                    }
                  self.table.reloadData()
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                      self.noRecordLabl.text = "No Records found"
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
    
    func sendLikeDislike(sModel:SearchCoursesModel,selectedIndex:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.courseId,] as [String : Any]
        
        if sModel.isLike {
            // "status":sModel.isLike
            params["status"] = "false"
        }else {
            params["status"] = "true"
        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let code  = json["Code"] as? Int,code == 200 {
                    if self.isSearching{
                        sModel.isLike = !sModel.isLike
                         self.searchCourseArray[selectedIndex] = sModel
                       self.table.reloadData()
                        return
                    }else{
                        sModel.isLike = !sModel.isLike
                          self.courseArray[selectedIndex] = sModel
                         self.table.reloadData()
                        return
                    }

                    
                    
                }
                
                if let _ = json["Payload"] as? [String:Any]{
                }
                else{
                    ActivityView.showToast(msg:json["Message"] as! String )
                }
                self.table.reloadData()
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









/*
import UIKit



protocol  MatchedProtocol {
    func matchedUniversityNameTapped(with model:SearchCoursesModel)
    func matchedCourseDetailsTapped(with courseId:String)
}

class MatchedCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var noRecordLabl: UILabel!
    @IBOutlet weak var table:UITableView!
    var courseArray = [SearchCoursesModel]()
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var delegate:MatchedProtocol?
    
    var isSearching = false
    
    var searchCourseArray = [SearchCoursesModel]()
    private var isSearchFetchingNextPage = false
    var searchPagingCounter              = 1
    var keyword               = ""
    
    func configure(){
        self.table.delegate           = self
        self.table.dataSource         = self
        self.table.prefetchDataSource = self
        table.rowHeight               = 150
        table.estimatedRowHeight      = UITableView.automaticDimension
        courseArray.removeAll()
        self.getCourses(with: 1, keyword: nil)
        addNotification()
    }
    
    
    //"matchSearch"
}

extension MatchedCollectionCell {
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMatchSearchKeyword(_:)), name: NSNotification.Name(rawValue: "matchSearch"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil)
        //Dismissed
    }
    
    
    // handle notification
    @IBAction  func getMatchSearchKeyword(_ notification: NSNotification) {
        if  let info = notification.userInfo as? [String:Any], let keyword = info["key"] as? String {
            self.isSearching = true
            self.getCourses(with: 1, keyword: keyword)
            self.keyword = keyword
        }
    }
   
    @IBAction  func dismissSearch(_ notification: NSNotification) {
        searchCourseArray.removeAll()
        self.isSearching = false
        self.isSearchFetchingNextPage = false
        self.searchPagingCounter = 1
        self.table.reloadData()
       
    }
}


//***********************************************//
// MARK: UITable Methods
//***********************************************//
extension MatchedCollectionCell:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isSearching {
            guard searchCourseArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.searchCourseArray.count-1 }
            if needsFetch && isSearchFetchingNextPage {
                self.getCourses(with: self.pagingCounter, keyword: self.keyword)
            }
            return
        }
        
        guard courseArray.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.courseArray.count-1 }
        if needsFetch && isFetchingNextPage {
            self.getCourses(with: self.pagingCounter, keyword:nil )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
             return searchCourseArray.count
        }
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return searchCourseCell(indexPath:indexPath, tableView: tableView)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if isSearching{
              let model = self.searchCourseArray[indexPath.row]
               model.isShowCourse = true
               delegate?.matchedUniversityNameTapped(with:model )
               return
           }
           let model = self.courseArray[indexPath.row]
           model.isShowCourse = true
           delegate?.matchedUniversityNameTapped(with:model)
       
    }
        
        
        
        
        
      /*  if isSearching{
            delegate?.matchedCourseDetailsTapped(with:searchCourseArray[indexPath.row].courseId)
            return
        }
        delegate?.matchedCourseDetailsTapped(with:courseArray[indexPath.row].courseId)
    }*/
}





extension MatchedCollectionCell {
    
    private func searchCourseCell(indexPath:IndexPath,tableView:UITableView) -> SearchCourseCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
        if isSearching{
             cell.configure(model: searchCourseArray[indexPath.row],isMatch: true)
        }else{
        cell.configure(model: courseArray[indexPath.row],isMatch: true)
        }
       
        cell.fevtBtn.tag = indexPath.row
        cell.fevtBtn.addTarget(self, action: #selector(fevtBtnTapped), for: .touchUpInside)
        cell.universityName.tag = indexPath.row
        cell.universityName.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
        
        cell.universityImageBtn.tag = indexPath.row
        cell.universityImageBtn.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
        cell.card.cardViewWithCornerRadius(10)
        cell.InsImage.cardViewWithCircle()
        return cell
    }
    
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearching{
            sendLikeDislike(sModel:self.searchCourseArray[sender.tag], selectedIndex: sender.tag )
           
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag], selectedIndex: sender.tag )
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        if isSearching{
           let model = self.searchCourseArray[sender.tag]
            model.isShowCourse = false
            delegate?.matchedUniversityNameTapped(with:model )
            return
        }
        let model = self.courseArray[sender.tag]
        model.isShowCourse = false
        delegate?.matchedUniversityNameTapped(with:model)
    }
    
}





//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension MatchedCollectionCell {
    func getCourses(with index:Int,keyword:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"pageNumber":index,"match_course_hide": "N"] as [String : Any]
        
        if self.isSearching{
            params["keyword"] =  keyword
        }
        WebServiceManager.instance.studentGetMatchedCoursesStatusWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                 ActivityView.hide()
                if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]]{
                    if let msg = json["Message"] as? String, msg ==  "No Records found" {
                        
                        if self.isSearching{
                            if  self.searchPagingCounter == 1 {
                                self.noRecordLabl.text = "No Records found"
                            }
                           self.isSearchFetchingNextPage = false
                             self.table.reloadData()
                            return
                        }
                         self.isFetchingNextPage = false
                        if  self.pagingCounter == 1 {
                            self.noRecordLabl.text = "No Records found"
                            
                        }
                         self.table.reloadData()
                        return
                    }
                    courseArr.forEach({ (dict) in
                        let model = SearchCoursesModel(with: dict)
                        if self.isSearching{
                            self.searchCourseArray.append(model)
                        }else{
                         self.courseArray.append(model)
                        }
                    })
                    
                    if self.isSearching{
                     self.searchPagingCounter += 1
                        self.isSearchFetchingNextPage = true
                    }else{
                        self.pagingCounter += 1
                        self.isFetchingNextPage = true
                    }
                  self.table.reloadData()
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                      self.noRecordLabl.text = "No Records found"
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
    
    func sendLikeDislike(sModel:SearchCoursesModel,selectedIndex:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.courseId,] as [String : Any]
        
        if sModel.isLike {
            // "status":sModel.isLike
            params["status"] = "false"
        }else {
            params["status"] = "true"
        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let code  = json["Code"] as? Int,code == 200 {
                    if self.isSearching{
                        sModel.isLike = !sModel.isLike
                         self.searchCourseArray[selectedIndex] = sModel
                       self.table.reloadData()
                        return
                    }else{
                        sModel.isLike = !sModel.isLike
                          self.courseArray[selectedIndex] = sModel
                         self.table.reloadData()
                        return
                    }

                    
                    
                }
                
                if let _ = json["Payload"] as? [String:Any]{
                }
                else{
                    ActivityView.showToast(msg:json["Message"] as! String )
                }
                self.table.reloadData()
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
*/
