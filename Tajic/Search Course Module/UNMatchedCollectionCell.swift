//
//  SearchFeatureCollectionCell.swift
//  CampusFrance
//
//  Created by UNICA on 19/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol  unMatchedProtocol {
    func universityNameTapped(with model:SearchCoursesModel)
    func courseDetailsTapped(with model:SearchCoursesModel)
}
//
class SearchFeatureCollectionCell: UICollectionViewCell {
    @IBOutlet weak var noDataLbl: UILabel!
    
    @IBOutlet weak var table:UITableView!
    var courseArray                 = [SearchCoursesModel]()
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var isSearchingNextPage        = false
    var SearchPagingCounter        = 1
    var isSearching                = false
    var searchResultArray          = [SearchCoursesModel]()
    var searchKeyWord              = ""
    var delegate:unMatchedProtocol?
    var clickMoreProtocol:clickMoreDelegate? = nil
    
    func configure(){
        table.rowHeight                  = 150
        table.estimatedRowHeight         = UITableView.automaticDimension
        table.delegate                   = self
        table.dataSource                 = self
        table.prefetchDataSource         = self
        getCourses(with: 1, keyWord: nil)
        addNotification()
    }
}


extension SearchFeatureCollectionCell {
    func addNotification(){
     NotificationCenter.default.addObserver(self, selector: #selector(self.getUnMatchSearchKeyword(_:)), name: NSNotification.Name(rawValue: "unMatchSearch"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil)
    }
    
  @IBAction  func getUnMatchSearchKeyword(_ notification: NSNotification) {
    if let dict = notification.userInfo as? [String:Any] , let keyWord = dict["key"] as? String{
        self.isSearching = true
        print(isSearching)
        self.searchKeyWord = keyWord
        self.getCourses(with: 1, keyWord: keyWord)
    }
    }
    
    @IBAction  func dismissSearch(_ notification: NSNotification) {
        self.isSearching = false
        print(isSearching)
        if searchResultArray.isEmpty == false {
            self.noDataLbl.text = ""
        }
        self.table.reloadData()
    }
}

extension SearchFeatureCollectionCell {
private func searchCourseCell(indexPath:IndexPath,tableView:UITableView) -> SearchCourseCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
    
    if isSearching{
       cell.configure(model: searchResultArray[indexPath.row],isMatch: false)
    }else{
         cell.configure(model: courseArray[indexPath.row],isMatch: false)
    }
   
    cell.fevtBtn.tag = indexPath.row
    cell.fevtBtn.addTarget(self, action: #selector(fevtBtnTapped), for: .touchUpInside)
    cell.universityName.tag = indexPath.row
    cell.universityName.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
    
    if cell.univeristyImageBtn != nil {
        cell.univeristyImageBtn.tag = indexPath.row
        cell.univeristyImageBtn.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
    }
    
    cell.card.cardViewWithCornerRadius(10)
    cell.InsImage.cardViewWithCircle()
    return cell
}
    
    func configureclickMoreCell(_ table:UITableView,index:IndexPath)->ClickMoreCell{
        let cell = table.dequeueReusableCell(withIdentifier: "ClickMoreCell") as! ClickMoreCell
        cell.configure()
        cell.layoutIfNeeded()
        cell.delegate = self
        return cell
    }
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearching{
           sendLikeDislike(sModel:self.searchResultArray[sender.tag] )
            self.searchResultArray[sender.tag].isLike =  !self.searchResultArray[sender.tag].isLike
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag] )
        self.courseArray[sender.tag].isLike =  !self.courseArray[sender.tag].isLike
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        if isSearching{
             delegate?.universityNameTapped(with:self.searchResultArray[sender.tag] )
            return
        }
        delegate?.universityNameTapped(with:self.courseArray[sender.tag] )
    }

}

extension SearchFeatureCollectionCell:clickMoreDelegate{
    func clickMoreTapped() {
        clickMoreProtocol?.clickMoreTapped()
    }
}
//***********************************************//
// MARK: UITable Methods
//***********************************************//
extension SearchFeatureCollectionCell:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isSearching {
            guard searchResultArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.searchResultArray.count-1 }
            if needsFetch && isSearchingNextPage {
                self.getCourses(with: self.SearchPagingCounter, keyWord:self.searchKeyWord)
            }
            return
        }
        guard courseArray.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.courseArray.count-1 }
        if needsFetch && isFetchingNextPage {
            self.getCourses(with: self.pagingCounter,keyWord:nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: if isSearching{
                   return searchResultArray.count
               }
        return courseArray.count
        default:return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return searchCourseCell(indexPath:indexPath, tableView: tableView)
        default:return configureclickMoreCell(tableView, index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:if isSearching {
            delegate?.courseDetailsTapped(with:searchResultArray[indexPath.row])
            return
        }
        delegate?.courseDetailsTapped(with:courseArray[indexPath.row])
        default:break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:return UITableView.automaticDimension
        default:return 100
        }
    }
}


//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension SearchFeatureCollectionCell {
    func getCourses(with index:Int, keyWord:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        
//        var  params =  ["app_agent_id":model.agentId,"user_id": model.id
//        ,"user_type":model.userType,"pageNumber":index,"match_course_hide": "Y"] as [String : Any]
        
        
        var  params = ["app_agent_id":model.agentId,"user_id": model.id,"user_type":model.userType,"page_number":index] as [String : Any]

        
        //
        
        //getSearchCourseFeatureListWithDetails
        if self.isSearching{
            params["keyword"] = keyWord
        }
        WebServiceManager.instance.getSearchCourseFeatureListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]], courseArr.isEmpty == false {
                      ActivityView.hide()
                    self.noDataLbl.text = ""
                    courseArr.forEach({ (dict) in
                        let model = SearchCoursesModel(with: dict)
                        if self.isSearching {
                            self.searchResultArray.append(model)
                        }else{
                           self.courseArray.append(model)
                        }
                    })
                    
                    if self.isSearching {
                       self.table.reloadData()
                        self.SearchPagingCounter += 1
                         self.isSearchingNextPage = true
                        return
                    }
                    self.table.reloadData()
                    self.pagingCounter += 1
                    self.isFetchingNextPage = true
                }
                else{
                    
                    if self.isSearching {
                        self.table.reloadData()
                        self.SearchPagingCounter = 1
                        self.isSearchingNextPage = false
                    }else{
                        self.table.reloadData()
                        self.pagingCounter = 1
                        self.isFetchingNextPage = false
                    }
                    
                    if let msg =  json["Message"] as? String {
                       self.noDataLbl.text = msg
                    }
                    
                   
                  //  self.showAlertMsg(msg: json["Message"] as! String)
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
    
    func sendLikeDislike(sModel:SearchCoursesModel) {
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
        WebServiceManager.instance.studentLikeFeatureCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let data = json["Payload"] as? [String:Any]{
                    print(data)
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


protocol  unMatchedProtocol {
    func universityNameTapped(with model:SearchCoursesModel)
    func courseDetailsTapped(with courseId:String)
}

class SearchFeatureCollectionCell: UICollectionViewCell {
    @IBOutlet weak var noDataLbl: UILabel!
    
    @IBOutlet weak var table:UITableView!
    var courseArray                 = [SearchCoursesModel]()
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var isSearchingNextPage        = false
    var searchPagingCounter        = 1
    var isSearching                = false
    var searchResultArray          = [SearchCoursesModel]()
    var searchKeyWord              = ""
    var isFilter                   = false
    var filterCountryId            = ""
    var delegate:unMatchedProtocol?
    var moreDelegate:clickMoreDelegate? = nil
    
    func configure(){
        table.rowHeight                  = 150
        table.estimatedRowHeight         = UITableView.automaticDimension
        table.delegate                   = self
        table.dataSource                 = self
        table.prefetchDataSource         = self
        getCourses(with: 1, keyWord: nil)
        addNotification()
    }
}


extension SearchFeatureCollectionCell {
    
    func addNotification(){
 NotificationCenter.default.addObserver(self, selector: #selector(self.getUnMatchSearchKeyword(_:)), name: NSNotification.Name(rawValue: "unMatchSearch"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterApplied(_:)), name: NSNotification.Name(rawValue: searchList.searchFilterApplied), object: nil)
              
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterClear(_:)), name: NSNotification.Name(rawValue:searchList.searchFilterClear), object: nil)
    }
    
  @IBAction  func getUnMatchSearchKeyword(_ notification: NSNotification) {
    if let dict = notification.userInfo as? [String:Any] , let keyWord = dict["key"] as? String{
        self.isSearching = true
        print(isSearching)
        self.searchKeyWord = keyWord
        self.getCourses(with: 1, keyWord: keyWord)
    }
   
    
    }
    
    @IBAction  func dismissSearch(_ notification: NSNotification) {
        
        self.isSearching = false
        
        print(isSearching)
        if searchResultArray.isEmpty == false {
            self.noDataLbl.text = ""
        }
        self.table.reloadData()
        
    }
    
    @IBAction  func filterApplied(_ notification: NSNotification) {
         if let dict = notification.userInfo as? [String:Any] , let keyWord = dict["id"] as? String{
        isFilter = true
            self.filterCountryId = keyWord
        if isSearching {
            self.searchPagingCounter = 1
            self.searchResultArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: searchPagingCounter, keyWord: self.searchKeyWord)
        }else{
            self.pagingCounter = 1
            self.courseArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: pagingCounter, keyWord:nil)
            }
            
        }
    }
    
    @IBAction  func filterClear(_ notification: NSNotification) {
        isFilter = false
        if isSearching {
            self.searchPagingCounter = 1
            self.searchResultArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: searchPagingCounter, keyWord: self.searchKeyWord)
        }else{
            self.pagingCounter = 1
            self.courseArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: pagingCounter, keyWord:nil)
        }
    }
}

extension SearchFeatureCollectionCell {
private func searchCourseCell(indexPath:IndexPath,tableView:UITableView) -> SearchCourseCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
    
    if isSearching{
       cell.configure(model: searchResultArray[indexPath.row],isMatch: false)
    }else{
         cell.configure(model: courseArray[indexPath.row],isMatch: false)
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
   
    func configureclickMoreCell(_ table:UITableView,index:IndexPath)->ClickMoreCell{
        let cell = table.dequeueReusableCell(withIdentifier: "ClickMoreCell") as! ClickMoreCell
        cell.configure()
        cell.layoutIfNeeded()
        cell.delegate = self
        return cell
    }
    
    
    
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearching{
           sendLikeDislike(sModel:self.searchResultArray[sender.tag] )
            self.searchResultArray[sender.tag].isLike =  !self.searchResultArray[sender.tag].isLike
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag] )
        self.courseArray[sender.tag].isLike =  !self.courseArray[sender.tag].isLike
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        if isSearching{
            let model = self.searchResultArray[sender.tag]
            model.isShowCourse =  false
             delegate?.universityNameTapped(with:model)
            return
        }
        let model = self.courseArray[sender.tag]
        model.isShowCourse =  false
        delegate?.universityNameTapped(with:model)
    }
}

extension SearchFeatureCollectionCell:clickMoreDelegate{
    func clickMoreTapped() {
        moreDelegate?.clickMoreTapped()
    }
    
}
//***********************************************//
// MARK: UITable Methods
//***********************************************//
extension SearchFeatureCollectionCell:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if isSearching {
            guard searchResultArray.isEmpty == false else{
                return
            }
            let needsFetch = indexPaths.contains { $0.row >= self.searchResultArray.count-1 }
            if needsFetch && isSearchingNextPage {
                self.getCourses(with: self.searchPagingCounter, keyWord:self.searchKeyWord)
            }
            return
        }
        guard courseArray.isEmpty == false else{
            return
        }
        let needsFetch = indexPaths.contains { $0.row >= self.courseArray.count-1 }
        if needsFetch && isFetchingNextPage {
            self.getCourses(with: self.pagingCounter,keyWord:nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let model = UserModel.getObject().tabDetails
        if model.isShowTabs == false {
            return 1
        }
        if model.isMatchTitle == false {
            return 1
        }
           return 2
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: if isSearching{
         return searchResultArray.count
               }
        return courseArray.count
        default:return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return searchCourseCell(indexPath:indexPath, tableView: tableView)
        default:return configureclickMoreCell(tableView, index: indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            let model = self.searchResultArray[indexPath.row]
            model.isShowCourse =  true
             delegate?.universityNameTapped(with:model)
            return
        }
        let model = self.courseArray[indexPath.row]
        model.isShowCourse =  true
        delegate?.universityNameTapped(with:model)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:return UITableView.automaticDimension
        default:return 100
        }
    }
}


//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension SearchFeatureCollectionCell {
    func getCourses(with index:Int, keyWord:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var  params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"pageNumber":index] as [String : Any]
        
        if self.isSearching{
            params["keyword"] = keyWord
        }
        
        if self.isFilter {
            params["filter_country_id"] = self.filterCountryId
        }
        
        WebServiceManager.instance.featureCourseListWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any],let  courseArr = data["courses"] as? [[String:Any]], courseArr.isEmpty == false {
                      ActivityView.hide()
                    self.noDataLbl.text = ""
                    courseArr.forEach({ (dict) in
                        let model = SearchCoursesModel(with: dict)
                        if self.isSearching {
                            self.searchResultArray.append(model)
                        }else{
                           self.courseArray.append(model)
                        }
                    })
                    
                    if self.isSearching {
                       self.table.reloadData()
                        self.searchPagingCounter += 1
                         self.isSearchingNextPage = true
                        return
                    }
                    self.table.reloadData()
                    self.pagingCounter += 1
                    self.isFetchingNextPage = true
                }
                else{
                    
                    if self.isSearching {
                        self.table.reloadData()
                        self.searchPagingCounter = 1
                        self.isSearchingNextPage = false
                    }else{
                        self.table.reloadData()
                        self.pagingCounter = 1
                        self.isFetchingNextPage = false
                    }
                    
                    if let msg =  json["Message"] as? String {
                       self.noDataLbl.text = msg
                    }
                    
                   
                  //  self.showAlertMsg(msg: json["Message"] as! String)
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
    
    func sendLikeDislike(sModel:SearchCoursesModel) {
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
        WebServiceManager.instance.studentLikeFeatureCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let data = json["Payload"] as? [String:Any]{
                    print(data)
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





