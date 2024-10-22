//
//  ShortListFeatureCollectionCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 06/04/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol featureProtocol {
    func courseDetails(vc:CourseDetailsVC)
    func instituteDetails(vc:InstituteBaseVC)
}
class ShortListFeatureCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var noRecordLabl: UILabel!
    @IBOutlet weak var table:UITableView!
    var courseArray = [ShortListModel]()
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var delegate:MatchedProtocol?
    var featureDelegate:featureProtocol? = nil
    var isSearching = false
    
    var searchCourseArray                = [ShortListModel]()
    private var isSearchFetchingNextPage = false
    var searchPagingCounter              = 1
    var keyword                          = ""
    var filterCountryId                  = ""
    var isFilter                         = false
    
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

extension ShortListFeatureCollectionCell {
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMatchkeyword(_:)), name: NSNotification.Name(rawValue: shortList.featuredSearch), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissSearch(_:)), name: NSNotification.Name(rawValue: shortList.featuredSearchDismiss), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.filterApplied(_:)), name: NSNotification.Name(rawValue: shortList.featuredFilterApplied), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.filterClear(_:)), name: NSNotification.Name(rawValue: shortList.featuredFilterClear), object: nil)
    }
    
    
    // handle notification
    @IBAction  func getMatchkeyword(_ notification: NSNotification) {
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
        self.pagingCounter = 1
        self.searchCourseArray.removeAll()
        self.courseArray.removeAll()
        self.table.reloadData()
        self.getCourses(with: self.pagingCounter, keyword: nil)
    }
    
    
    
    @IBAction  func filterApplied(_ notification: NSNotification) {
         if let dict = notification.userInfo as? [String:Any] , let keyWord = dict["id"] as? String{
        isFilter = true
            self.filterCountryId = keyWord
        if isSearching {
            self.searchPagingCounter = 1
            self.searchCourseArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: searchPagingCounter, keyword: self.keyword)
        }else{
            self.pagingCounter = 1
            self.courseArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: pagingCounter, keyword:nil)
            }
            
        }
    }
    
    @IBAction  func filterClear(_ notification: NSNotification) {
        isFilter = false
        if isSearching {
            self.searchPagingCounter = 1
            self.searchCourseArray.removeAll()
            self.table.reloadData()
            self.getCourses(with: 1, keyword: self.keyword)
        }else{
            self.pagingCounter = 1
            self.courseArray.removeAll()
            self.table.reloadData()
             self.getCourses(with: 1, keyword:nil)
        }
    }
    
}


//***********************************************//
// MARK: UITable Methods
//***********************************************//
extension ShortListFeatureCollectionCell:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching{
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      if isSearching {
          guard searchCourseArray.isEmpty == false else{
              return
          }
          let needsFetch = indexPaths.contains { $0.row >= self.searchCourseArray.count-1 }
          if needsFetch && isSearchFetchingNextPage {
              self.getCourses(with: self.searchPagingCounter, keyword: keyword)
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
      if isSearching {
          return searchCourseArray.count
      }
      return courseArray.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return configureCell(tableView, index: indexPath)
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if isSearching {
        let model = searchCourseArray[indexPath.row]
        model.isShowCourse = true
        model.isFromFeature = true
        self.universityNameTapped(model: model)
      
          return
      }
    
    let model = courseArray[indexPath.row]
    model.isShowCourse = true
    model.isFromFeature = true
    self.universityNameTapped(model: model)
      }
    
  }

extension ShortListFeatureCollectionCell {
    func configureCell(_ table:UITableView, index:IndexPath)-> ShortListCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ShortListCell") as! ShortListCell
        cell.delegate = self
        cell.fevtBtn.tag = index.row
        if isSearching {
           cell.configure(searchCourseArray[index.row])
        }else{
            cell.configure(courseArray[index.row])
        }
        cell.layoutIfNeeded()
        cell.card.cardViewWithCornerRadius(10)
        return cell
    }
    

    func courseDetailsTapped(with courseId: String) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
        vc.courseId = courseId
        vc.isFormFeature = true
        featureDelegate?.courseDetails(vc: vc)
    }
}
extension ShortListFeatureCollectionCell:shortDelegate {
    func universityNameTapped(model: ShortListModel) {
              if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                  vc.instituteID = model.universityId
                  vc.titleName = model.universityName
                  vc.isFormFeature = true
                    //false//
                    
                    vc.isShowCourse = model.isShowCourse
                vc.courseId = model.courseId
                 featureDelegate?.instituteDetails(vc: vc)
              }
          }
    
    func isLikeBtnTapped(model: ShortListModel, index: Int) {
         sendLikeDislike(sModel:model, selectedIndex:index)
    }
    
}


extension ShortListFeatureCollectionCell {
        
    @IBAction func fevtBtnTapped(_ sender: UIButton) {
        if isSearching{
            sendLikeDislike(sModel:self.searchCourseArray[sender.tag], selectedIndex: sender.tag )
            return
        }
        sendLikeDislike(sModel:self.courseArray[sender.tag], selectedIndex: sender.tag )
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton) {
        if isSearching{
            return
        }
        
    }
    
}





//***********************************************//
// MARK: Web Service Methods
//***********************************************//
extension ShortListFeatureCollectionCell {
    func getCourses(with index:Int,keyword:String?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id,
                      "page_number":index] as [String : Any]
        
        if self.isSearching{
            params["keyword"] =  keyword
        }
        
        if isFilter {
            params["filter_country_id"] = self.filterCountryId
        }
        WebServiceManager.instance.getShortListedFeatureCourseDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                 ActivityView.hide()
                 self.noRecordLabl.text = ""
                 if let code = json["Code"] as? Int, code == 200||code == 404 && index == 1,let payload = json["Payload"] as? String,payload.isEmpty {
                    if let msg =  json["Message"] as? String {
                        self.noRecordLabl.text = msg
                    }
                    self.table.reloadData()
                    return
                 }
                 if let code = json["Code"] as? Int, code == 200||code == 404 && index == 1,let courseArr = json["Payload"] as? [[String:Any]],courseArr.isEmpty  {
                    if let msg =  json["Message"] as? String {
                        self.noRecordLabl.text = msg
                    }
                    self.table.reloadData()
                    return
                 }
                 
                 if let courseArr = json["Payload"] as? [[String:Any]],courseArr.isEmpty == false {
                    courseArr.forEach({ (dict) in
                        let model = ShortListModel(dict)
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
                     // self.noRecordLabl.text = "No Records found"
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
    
    func sendLikeDislike(sModel:ShortListModel,selectedIndex:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        var params = ["app_agent_id":model.agentId,"user_id": model.id
            ,"user_type":model.userType,"course_id":sModel.courseId,] as [String : Any]
        params["status"] = "false"
//        if sModel.isLike {
//            // "status":sModel.isLike
//            params["status"] = "false"
//        }else {
//            params["status"] = "true"
//        }
        ActivityView.show()
        WebServiceManager.instance.studentLikeFeatureCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                ActivityView.hide()
                if let code  = json["Code"] as? Int,code == 200 {
                    if let msg = json["Message"] as? String {
                      ActivityView.showToast(msg:msg)
                    }
                    if self.isSearching{
                        self.searchCourseArray.remove(at: selectedIndex)
                       self.table.reloadData()
                        return
                    }else{
                          self.courseArray.remove(at: selectedIndex)
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


