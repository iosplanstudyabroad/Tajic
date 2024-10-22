//
//  ShortListVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 20/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ShortListVC: UIViewController {
    //@IBOutlet weak var table:UITableView!
    @IBOutlet weak var nolabel:UILabel!
    
    @IBOutlet var whatsAppBtn: UIButton!
    
    @IBOutlet var callBtn: UIButton!
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
    CustomSearchView
    
    var searchKeyWord      = ""
    var isSearchForFevt = false
    var isSearching = false
    
    var searchCourseArray        = [ShortListModel]()
    var isSearchEnabled          = false
    var courseArray              = [ShortListModel]()
    var isSearchFetchingNextPage = false
    var searchPagingCounter      = 1
    var isFetchingNextPage       = false
    var pagingCounter            = 1
    var filterButton             = UIButton()
    var selectedFilter           = CountryModel()
    
    
    
    var isFeatureFilterApplied      = false
       var isPerfectMatchFilterApplied = false
       var isFeatureFilterAvalible     = true
       var isPerfectFilterAvalible     = false
        var pageTitle = ""
    //***********************************************//
    // MARK:New Outlets
    //***********************************************//
    
    @IBOutlet var menuHeightConstant: NSLayoutConstraint!
       @IBOutlet weak var matchBackView: UIView!
       @IBOutlet weak var matchLowerView: UIView!
       @IBOutlet weak var unMatchBackView: UIView!
       @IBOutlet weak var unMatchLowerView: UIView!
       @IBOutlet weak var matchBtn:UIButton!
       @IBOutlet weak var unmatchBtn:UIButton!
      @IBOutlet weak var collection:UICollectionView!
        var isSearchForFeature =  true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func configure(){
        isFeatureFilterAvalible = true
        whatsAppBtn.titleLabel?.numberOfLines = 0
        whatsAppBtn.titleLabel?.textAlignment = .center
        whatsAppBtn.titleLabel?.lineBreakMode = .byWordWrapping
        callBtn.titleLabel?.numberOfLines     = 0
        callBtn.titleLabel?.textAlignment     = .center
        callBtn.titleLabel?.lineBreakMode     = .byWordWrapping
        whatsAppBtn.cornerRadius(10)
        callBtn.cornerRadius(10)
        //self.table.rowHeight = 160
        //self.table.estimatedRowHeight = UITableView.automaticDimension
       
       // getCourses(with: 1, keyword: nil)
        
        matchLowerView.backgroundColor   = UIColor.clear
        unMatchLowerView.backgroundColor =  UIColor().hexStringToUIColor(hex: "343434")
        addLeftMenuBtnOnNavigation()
       
        configureTabs()
        
    }
    func configureTabs(){
        let model = UserModel.getObject().tabDetails
        menuHeightConstant.constant = 20
         matchBackView.isHidden = true
        unMatchBackView.isHidden = true
        if model.isShowTabs {
            menuHeightConstant.constant = 20
            matchBackView.isHidden = true
            unMatchBackView.isHidden = true
            if model.isMatchTitle {
                self.matchBtn.setTitle(model.matchTitle.uppercased(), for: .normal)
                menuHeightConstant.constant = 50
                matchBackView.isHidden = false
            }
            if model.isFeaturedTitle {
                self.unmatchBtn.setTitle(model.featuredTitle.uppercased(), for: .normal)
                menuHeightConstant.constant = 50
                unMatchBackView.isHidden = false
                }
        }else{
        menuHeightConstant.constant = 20
         matchBackView.isHidden = true
        unMatchBackView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlertMsg(msg: model.message)
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(true)
              if isSearching {
                  searchView.removeFromSuperview()
                  self.navigationController?.navigationBar.addSubview(searchView)
              }
          }
          
          override func viewWillDisappear(_ animated: Bool) {
              searchView.removeFromSuperview()
          }

   //***********************************************//
   // MARK: UIButton Action Defined Here
   //***********************************************//
    
    
    @IBAction func searchCourseBtnTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCourseVC") as? SearchCourseVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   @IBAction func menuBtnTapped(_ sender: Any) {
       if AppSession.share.isFormNotification {
          
           AppSession.share.isFormNotification =  false
           AppDelegate.shared.setRootViewController(vc: .Home)
           return
       }
       self.slideMenuController()?.openLeft()
   }
    

       
       @IBAction func matchedBtnTapped(_ sender: Any) {
           
       
        
            searchView.searchtext.text = ""
            searchView.removeFromSuperview()
            isSearchForFeature = false
           matchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
           unMatchLowerView.backgroundColor = UIColor.clear
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredSearchDismiss), object: nil, userInfo:nil)
        if isFeatureFilterApplied {
                   self.resetFeatureFilter()
               }
                       isFeatureFilterAvalible     = false
                      isPerfectFilterAvalible     = true
        
        
        let index = IndexPath(item: 1, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
               
       }
       
       
       @IBAction func unMatchedBtnTapped(_ sender: Any) {
        
       
        
        
            searchView.searchtext.text = ""
            searchView.removeFromSuperview()
           isSearchForFeature = true
           
           matchLowerView.backgroundColor =  UIColor.clear
           unMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
           
           
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.prefectSearchDismiss), object: nil, userInfo:nil)
        if isPerfectMatchFilterApplied {
                   self.resetPerfectMatchFilter()
               }
               isFeatureFilterAvalible     = true
               isPerfectFilterAvalible     = false
        
        
        let index = IndexPath(item: 0, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
       }
    
    
    @IBAction func whatsAppBtnTApped(_ sender: UIButton) {
           let what = AppSession.share.agentWhatsup
           if what.isEmpty == false {
            openWhatsapp(what,"")
           }else{
           showAlertMsg(msg: "Whatsapp number is not present")
        }
       }
    
    
    @IBAction func callBtnTapped(_ sender:UIButton){
        let phone = AppSession.share.agentMobile
        if phone.isEmpty == false {
           callNumber(phoneNumber: phone)
        }else{
            showAlertMsg(msg: "Mobile number is not present")
        }
    }
       @IBAction func   filterBtnTapped(_ sender:UIButton){
           self.view.endEditing(true)
           if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryFilterVC") as? CountryFilterVC {
               vc.delegate        = self
               vc.country = selectedFilter
            vc.isPerfectMatch = isPerfectFilterAvalible
               if let window = UIApplication.shared.keyWindow {
                   window.rootViewController?.add(vc)
               }
           }
       }
    
   
    
    
    
    
    
}

//***********************************************//
// MARK: Filter Protocol
//***********************************************//
extension ShortListVC:CountryFilterDelegate{
     func getFilterQueryFeature(_ country: CountryModel) {
           self.isFeatureFilterApplied = true
           self.selectedFilter = country
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredFilterApplied), object: nil, userInfo:["id":country.id])
       }
       
       func getFilterQueryPerfect(_ country: CountryModel) {
           self.isPerfectMatchFilterApplied = true
           self.selectedFilter = country
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.perfectMatchFilterApplied), object: nil, userInfo:["id":country.id])
       }
    
    func resetFeatureFilter() {
              self.isFeatureFilterApplied = false
              self.selectedFilter = CountryModel()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredFilterClear), object: nil, userInfo:nil)
          }
          
          func resetPerfectMatchFilter() {
              self.selectedFilter = CountryModel()
              self.isPerfectMatchFilterApplied = false
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.perfectMatchFilterClear), object: nil, userInfo:nil)
          }
   
    
    func resetTaskFilter() {
        
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredFilterClear), object: nil, userInfo:nil)
    }
    
    func getFilterQuery(_ country: CountryModel) {
        self.selectedFilter = country
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredFilterApplied), object: nil, userInfo:["id":country.id])
    }
    
}



extension ShortListVC{
    
    func openWhatsapp(_ phone:String,_ text:String){
        
        let urlWhats = "whatsapp://send?phone=\(phone)&abid=12354&text=\(text)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    self.showAlertMsg(msg: "Install Whatsapp")
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    
    
    private func callNumber(phoneNumber:String) {
        var number = phoneNumber.replacingOccurrences(of: "+", with: "")
             number = number.replacingOccurrences(of: " ", with: "")
      if let phoneCallURL = URL(string: "tel://\(number)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}
extension ShortListVC{
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "Menu.png"), for: .normal)
        if AppSession.share.isFormNotification {
                               
               menuButton.setImage(UIImage(named: "arrow_left.png"), for: .normal)
                            }
        menuButton.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
        menuButton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 45))
        leftView.addSubview(menuButton)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 180, height: 45))
        titleLbl.text = pageTitle
        if pageTitle.isEmpty {
            titleLbl.text = "Shortlisted Courses"
        }
        
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let menuBarButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = menuBarButton
        let searchButton                                        = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "searchNew.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
        searchButton.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
        
        filterButton                                        = UIButton(type: .custom)
                           filterButton.setImage(UIImage(named: "filter.png"), for: .normal)
                           
                           filterButton.frame                                      = CGRect(x: 0, y: 0, width: 45, height: 45)
                           filterButton.addTarget(self, action: #selector(filterBtnTapped), for: .touchUpInside)
               
               let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
               rightView.addSubview(searchButton)
                      rightView.addSubview(filterButton)
        
        
        
        let rightMenu                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = rightMenu
    }
    
    
    func statusBarHeight() -> CGFloat {
           let statusBarSize = UIApplication.shared.statusBarFrame.size
           return Swift.min(statusBarSize.width, statusBarSize.height)
       }
       @IBAction func searchBtnTapped(_ sender: Any) {
           let frame                  = CGRect(x: 0, y: -statusBarHeight(), width: (self.navigationController?.navigationBar.frame.size.width)!, height: ((self.navigationController?.navigationBar.frame.size.height)!)+statusBarHeight())
           searchView.frame           = frame
           searchView.navigationFrame = (self.navigationController?.navigationBar.frame)!
           searchView.confrigureSearchView()
           searchView.delegate = self
           searchView.removeFromSuperview()
           self.navigationController?.navigationBar.addSubview(searchView)
       //    isSearching = true
       }
       
}



extension ShortListVC:searchProtocol{
    func getSearchKeyword(keyWord: String) {
          if isSearchForFeature {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredSearch), object: nil, userInfo:["key":keyWord])
          }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.prefectSearch), object: nil, userInfo:["key":keyWord])
          }
          print("keyword for search in SearchCourseVC  is \(keyWord)")
      }
      func searchViewDismissed() {
          isSearching = false
          if isSearchForFeature {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.featuredSearchDismiss), object: nil, userInfo:nil)
          }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: shortList.prefectSearchDismiss), object: nil, userInfo:nil)
          }
      }
    
    
    
    
    
    
    
    
    
    
    
    /*
    func getSearchKeyword(keyWord: String) {
        self.isSearchEnabled = true
        print(isSearchEnabled)
        self.nolabel.text = ""
        self.searchCourseArray.removeAll()
        //self.table.reloadData()
        self.searchKeyWord = keyWord
        self.searchPagingCounter = 1
        self.getCourses(with: 1, keyword: keyWord)
    }
    func searchViewDismissed() {
        self.isSearchEnabled = false
        if courseArray.isEmpty == false {
            self.nolabel.text =  ""
        }
        print(isSearchEnabled)
        //self.table.reloadData()
    }
    
    */
}


//***********************************************//
// MARK: Table Delegate Methods
//***********************************************//
extension ShortListVC:UITableViewDelegate,UITableViewDataSource
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
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView, index: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchEnabled {
        courseDetailsTapped(with:searchCourseArray[indexPath.row].courseId )
            return
        }
        courseDetailsTapped(with:courseArray[indexPath.row].courseId )
        }
    }

extension ShortListVC {
    func configureCell(_ table:UITableView, index:IndexPath)-> ShortListCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ShortListCell") as! ShortListCell
        cell.delegate = self
        cell.fevtBtn.tag = index.row
        if isSearchEnabled {
           cell.configure(searchCourseArray[index.row])
        }else{
            cell.configure(courseArray[index.row])
        }
        cell.layoutIfNeeded()
        cell.card.cardViewWithCornerRadius(10)
        return cell
    }
    

    func courseDetailsTapped(with courseId: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
        vc.courseId = courseId
        self.navigationController!.pushViewController(vc, animated: false)
    }
}

extension ShortListVC:shortDelegate{
    func isLikeBtnTapped(model: ShortListModel,index:Int) {
        print(model.universityName)
        sendLikeDislike(sModel: model, index: index)
    }
    
    func universityNameTapped(model: ShortListModel) {
   if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
        vc.instituteID = model.universityId
        vc.titleName = model.courseName
        vc.isFormFeature = model.isFromFeature
        vc.isShowCourse = model.isShowCourse
        self.navigationController?.pushViewController(vc, animated: true)
    }
             
          }
}
extension ShortListVC{
    
    func sendLikeDislike(sModel:ShortListModel,index:Int) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        
        let model = UserModel.getObject()
        let params = ["app_agent_id":model.agentId,"user_id": model.id,"user_type":model.userType,"course_id":sModel.courseId,"status":"false"] as [String : Any]
    
        ActivityView.show()
       
        WebServiceManager.instance.studentLikeCourseWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
               
                if let code = json["Code"] as? Int, code == 200{
                    
                    if self.isSearchEnabled {
                        //sModel.isLike = !sModel.isLike
                        self.searchCourseArray.remove(at: index)
                       // self.searchCourseArray[index] = sModel
                         //self.table.isHidden = false
                        if self.searchCourseArray.isEmpty {
                            //self.table.isHidden = true
                        }
                    }else{
                       // sModel.isLike = !sModel.isLike
                       // self.courseArray[index] = sModel
                        //self.table.isHidden = false
                        self.courseArray.remove(at: index)
                        if self.courseArray.isEmpty {
                            //self.table.isHidden = true
                        }
                    }
                    //self.table.reloadData()
                }
                
                if let _ = json["Payload"] as? [String:Any]{
                   
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                }
               
                //self.table.reloadData()
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
extension ShortListVC {
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
                if let code = json["Code"] as? Int, code == 404 && pageNumber == 1 {
                    if let msg = json["Message"] as? String{
                        self.showAlertMsg(msg: msg)
                        if pageNumber == 1 {
                            //self.table.isHidden = true
                            self.nolabel.text   = ""
                        }
            }
                     ActivityView.hide()
                    return
                }
                if let courseArr = json["Payload"] as? [[String:Any]],courseArr.isEmpty == false {
                    courseArr.forEach({ (dict) in
                        let model = ShortListModel( dict)
                        if self.isSearchEnabled{
                            self.searchCourseArray.append(model)
                        }else{
                            self.courseArray.append(model)
                        }
                    })
                    //self.table.reloadData()
                    //self.table.isHidden = false
                    if self.isSearchEnabled{
                        self.isSearchFetchingNextPage = true
                        self.searchPagingCounter     += 1
                    }else{
                        self.isFetchingNextPage  = true
                        self.pagingCounter      += 1
                    }
                      self.nolabel.text = ""
                      //self.table.reloadData()
                }
                else{
                    if self.isSearchEnabled{
                        self.isSearchFetchingNextPage = false
                    }else{
                        self.isFetchingNextPage  = false
                    }
                    if let msg = json["Message"] as? String{
                        self.nolabel.text = ""
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
}

extension ShortListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = UserModel.getObject().tabDetails
        if model.isMatchTitle && model.isFeaturedTitle {
            return 2
        }
        if model.isMatchTitle == false && model.isFeaturedTitle == false {
            return 0
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = UserModel.getObject().tabDetails
        switch indexPath.item {
        case 0 :if model.isFeaturedTitle {
                 return unMmatchCellWith(indexPath:indexPath, collectionView)
             }
            if model.isMatchTitle {
                return matchCellWith(indexPath:indexPath, collectionView)
                }
        default:if model.isMatchTitle {
         return matchCellWith(indexPath:indexPath, collectionView)
        }
       
        return  unMmatchCellWith(indexPath:indexPath, collectionView)
        }
        return matchCellWith(indexPath:indexPath, collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    
    func matchCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> ShortListMatchedCollectionCell{
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortListMatchedCollectionCell", for: indexPath) as! ShortListMatchedCollectionCell
        cell.featureDelegate = self
        cell.layoutIfNeeded()
        cell.configure()
        return cell
    }
    
    func unMmatchCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> ShortListFeatureCollectionCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortListFeatureCollectionCell", for: indexPath) as! ShortListFeatureCollectionCell
        cell.featureDelegate = self
        cell.layoutIfNeeded()
        cell.configure()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        switch currentPage {
        case 0:matched()
        
        default: unmatched()
        }
    }
    
    func matched(){
        
        matchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
            unMatchLowerView.backgroundColor = UIColor.clear
         isSearchForFeature = false
        searchView.removeFromSuperview()
        searchView.searchtext.text = ""
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
    }
    
    func unmatched(){
        
        matchLowerView.backgroundColor =  UIColor.clear
        unMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
         isSearchForFeature = false
        searchView.removeFromSuperview()
        searchView.searchtext.text = ""
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
    }
}


extension ShortListVC:featureProtocol{
    func instituteDetails(vc: InstituteBaseVC) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func courseDetails(vc: CourseDetailsVC) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
