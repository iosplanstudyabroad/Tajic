//
//  NewSearchCourseVC.swift
//  SVC
//
//  Created by Mohit Kumar  on 27/11/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class NewSearchCourseVC: UIViewController {
    @IBOutlet var menuHeightConstant: NSLayoutConstraint!
    @IBOutlet var featureCRMCourseBtn:UIButton!
    @IBOutlet var featureBackView: UIView!
    @IBOutlet var featureLowerView: UIView!
    @IBOutlet var perfectMatchUnicaCourseBtn:UIButton!
    @IBOutlet var perfectMatchBackView: UIView!
    @IBOutlet var perfectMatchLowerView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var featureListBackView: UIView!
    @IBOutlet var featureTable:UITableView!
    @IBOutlet var perfectTable:UITableView!
    @IBOutlet var perfectMatchListBackView: UIView!
    
    var featureCourseList      = [SearchCoursesModel]()
    var perfectMatchCourseList = [SearchCoursesModel]()
    var featurePagingCounter   = 1
    var perfectPagingCounter   = 1
    
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
    CustomSearchView
    var isSearchForFeature   =  true
    var isFeatureFetchEnable = true
    var isPerfectFetchEnable = true
    var isSearching          = false
    var keyword:String?
    var countryFilter:String?
    var filterButton         = UIButton()
    var selectedFilter       = CountryModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func featureCRMCourseBtnTapped(_ sender: Any) {
        perfectMatchLowerView.backgroundColor = .clear
        featureLowerView.backgroundColor      = UIColor().hexStringToUIColor(hex: "343434")
        scrollOnButtonTapped(x: CGFloat(0))
        if isSearching {
            searchBackBtnTapped(sender)
           searchViewDismissed()
        }
        isSearchForFeature = true
    }
    
    @IBAction func perfectMatchUnicaCourseBtnTapped(_ sender: Any) {
        perfectMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
        featureLowerView.backgroundColor      = .clear
        scrollOnButtonTapped(x: CGFloat(self.view.frame.size.width))
        if isSearching {
            searchBackBtnTapped(sender)
           searchViewDismissed()
        }
        isSearchForFeature = false
    }
    
    func scrollOnButtonTapped(x:CGFloat){
        scrollView.setContentOffset(CGPoint(x: x , y: 0), animated: true)
    }
    @IBAction func menuBtnTapped(_ sender: Any) {
        if self.isEditing {
            AppDelegate.shared.setRootViewController(vc: .Home)
            return
        }
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func searchBackBtnTapped(_ sender: Any) {
         self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { [] in // allowing to ARC to deallocate it properly
            self.view.layoutIfNeeded()
            self.searchView.removeFromSuperview()
        }
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
        isSearching = true
    }
    
    
    @IBAction func filterBtnTapped(_ sender:UIButton){
        self.view.endEditing(true)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryFilterVC") as? CountryFilterVC {
            vc.delegate        = self
            vc.country  = selectedFilter
            vc.isPerfectMatch = !isSearchForFeature
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
}

extension NewSearchCourseVC {
    func configure(){
        scrollView.delegate = self
        self.addLeftMenuBtnOnNavigation()
        DispatchQueue.main.async {
            self.configureTabs()
        }
    }
    
    func configureTabs(){
        let model = UserModel.getObject().tabDetails
        menuHeightConstant.constant = 20
        featureBackView.isHidden      = true
        perfectMatchBackView.isHidden    = true
        if model.isShowTabs {
            menuHeightConstant.constant = 20
            if model.isFeaturedTitle {
            self.featureCRMCourseBtn.setTitle(model.featuredTitle.uppercased(), for: .normal)
                menuHeightConstant.constant = 50
                featureBackView.isHidden    = false
                featureLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
                perfectMatchLowerView.backgroundColor = .clear
                self.callFeatureService(1, nil,self.countryFilter)
                }
            if model.isMatchTitle {
                self.perfectMatchUnicaCourseBtn.setTitle(model.matchTitle.uppercased(), for: .normal)
                menuHeightConstant.constant   = 50
                perfectMatchBackView.isHidden = false
                if model.isFeaturedTitle == false  {
                    featureLowerView.backgroundColor = .clear
                    perfectMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
                }
                self.callPerfectService(1, nil,self.countryFilter)
            }
        }else{
         menuHeightConstant.constant   = 20
         perfectMatchBackView.isHidden = true
         featureBackView.isHidden      = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlertMsg(msg: model.message)
            }
        }
    }
    
    func callFeatureService(_ index:Int,_ keyWord:String?,_ coutnryFilter:String?){
        let model = NewSearchCourseViewModel()
        model.getFeatureCourseList(index: index, keyWord: keyWord,filter: coutnryFilter) { (statusCode,pageNumber, courseArray)  in
            DispatchQueue.main.async {
                if courseArray.isEmpty == false {
                    self.featurePagingCounter += 1
                }
                if courseArray.isEmpty && statusCode == 404 {
                    self.isFeatureFetchEnable = false
                    self.featurePagingCounter = 1
                    self.featureTable.reloadData()
                    return
                }
               self.featureCourseList.append(contentsOf: courseArray)
                self.featureTable.reloadData()
            }
        }
    }
    
    func callPerfectService(_ index:Int,_ keyWord:String?,_ coutnryFilter:String?){
        let model = NewSearchCourseViewModel()
        model.getPefectMatchCourseList(index: index, keyWord: keyWord, filter: self.countryFilter) { (statusCode,pageNumber, courseArray) in
            DispatchQueue.main.async {
                if courseArray.isEmpty == false {
                   self.perfectPagingCounter += 1
                }
                if courseArray.isEmpty && statusCode == 404 {
                    self.isPerfectFetchEnable = false
                    self.perfectPagingCounter = 1
                    self.perfectTable.reloadData()
                    return
                }
            self.perfectMatchCourseList.append(contentsOf: courseArray)
                self.perfectTable.reloadData()
            }
        }
    }
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "Menu.png"), for: .normal)
        if AppSession.share.isFormNotification {
               menuButton.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        }
        if self.isEditing {
            menuButton.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        }
        menuButton.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
        menuButton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuButton)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        titleLbl.text = "Search Courses"
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let menuBarButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = menuBarButton
        let searchButton                                        = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "searchNew.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
        searchButton.frame                                      = CGRect(x: 0, y: 0, width: 45, height: 45)
        
        
        filterButton  = UIButton(type: .custom)
        filterButton.setImage(UIImage(named: "filter.png"), for: .normal)
                    
        filterButton.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
        filterButton.addTarget(self, action: #selector(filterBtnTapped), for: .touchUpInside)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        rightView.addSubview(searchButton)
               rightView.addSubview(filterButton)
        
        let searchBarBtn                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = searchBarBtn
    }
}

extension NewSearchCourseVC:searchProtocol,CountryFilterDelegate{
    func getFilterQueryFeature(_ country: CountryModel) {
        print("getFilterQueryFeature",country.name, country.id)
        self.selectedFilter = country
        self.countryFilter = country.id
        self.featurePagingCounter = 1
        self.featureCourseList.removeAll()
        self.featureTable.reloadData()
        self.isFeatureFetchEnable = true
        self.callFeatureService(self.featurePagingCounter, self.keyword, self.countryFilter)
    }
    
    func getFilterQueryPerfect(_ country: CountryModel) {
        self.selectedFilter = country
        self.countryFilter = country.id
        self.perfectPagingCounter = 1
        self.perfectMatchCourseList.removeAll()
        self.perfectTable.reloadData()
        self.isPerfectFetchEnable = true
        self.callPerfectService(self.perfectPagingCounter, self.keyword, self.countryFilter)
    }
    
    func resetFeatureFilter() {
        print("resetFeatureFilter")
        self.selectedFilter = CountryModel()
        self.countryFilter = nil
        self.featurePagingCounter = 1
        self.featureCourseList.removeAll()
        self.featureTable.reloadData()
        self.isFeatureFetchEnable = true
        self.callFeatureService(self.featurePagingCounter, self.keyword, self.countryFilter)
    }
    
    func resetPerfectMatchFilter() {
        self.selectedFilter = CountryModel()
        self.countryFilter = nil
        self.perfectPagingCounter = 1
        self.perfectMatchCourseList.removeAll()
        self.perfectTable.reloadData()
        self.isPerfectFetchEnable = true
        self.callPerfectService(self.perfectPagingCounter, self.keyword, self.countryFilter)
    }
    
    
    func getSearchKeyword(keyWord: String) {
        if isSearchForFeature {
            self.isFeatureFetchEnable = true
            self.isSearching = true
            self.keyword = keyWord
            self.featureCourseList.removeAll()
            self.featureTable.reloadData()
            self.featurePagingCounter = 1
            self.callFeatureService(1, keyWord, self.countryFilter)
            return
        }
        self.isPerfectFetchEnable = true
        self.isSearching = true
        self.keyword = keyWord
        self.perfectMatchCourseList.removeAll()
        self.perfectTable.reloadData()
        self.perfectPagingCounter = 1
        self.callPerfectService(1, keyWord,self.countryFilter)
    }
    
    func searchViewDismissed() {
        if isSearchForFeature {
            self.isFeatureFetchEnable = true
            self.isSearching = false
            self.keyword = nil
            self.featureCourseList.removeAll()
            self.featureTable.reloadData()
            self.featurePagingCounter = 1
            self.callFeatureService(1, nil,self.countryFilter)
            return
        }
        self.isPerfectFetchEnable = true
        self.isSearching = false
        self.keyword = nil
        self.perfectMatchCourseList.removeAll()
        self.perfectTable.reloadData()
        self.perfectPagingCounter = 1
        self.callPerfectService(1, nil,self.countryFilter)
    }
}
extension NewSearchCourseVC:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let  scroll = scrollView as? UITableView {
            print(scroll)
            return
        }
       let currentPage                                = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        switch currentPage {
        case 0:featureLowerView.backgroundColor       =  UIColor().hexStringToUIColor(hex: "343434")
             perfectMatchLowerView.backgroundColor    = UIColor.clear
        if isSearching {
           searchViewDismissed()
        }
         isSearchForFeature                           = true
        searchView.removeFromSuperview()
        searchView.searchtext.text                    = ""
        default:featureLowerView.backgroundColor      = UIColor.clear
                perfectMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
             if isSearching {
                searchViewDismissed()
             }
             isSearchForFeature                       = false
            searchView.removeFromSuperview()
            searchView.searchtext.text                = ""
        }
    }
}

extension NewSearchCourseVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView.tag {
        case 10:return 1
        default:return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 10:return featureCourseList.count
        default:return perfectMatchCourseList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 10:return configureSearchCell(tableView, indexPath, false,"Feature")
        default:return configureSearchCell(tableView, indexPath, true,"Perfect")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 10: if isFeatureFetchEnable {
            if featureCourseList.count - 1 == indexPath.row {
                self.callFeatureService(self.featurePagingCounter, self.keyword,self.countryFilter)
            }
            }
        default:if isPerfectFetchEnable {
            if perfectMatchCourseList.count - 1 ==  indexPath.row {
                self.callPerfectService(self.perfectPagingCounter, self.keyword,self.countryFilter)
            }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 10:let model = self.featureCourseList[indexPath.row]
        model.isFromFeature = true
        model.isShowCourse = true
        self.moveToUniversityDetails(model)
        default:let model = self.perfectMatchCourseList[indexPath.row]
            model.isFromFeature = false
            model.isShowCourse = true
            self.moveToUniversityDetails(model)
        }
    }
}
extension NewSearchCourseVC:clickMoreDelegate {
    private func configureSearchCell(_ table:UITableView,_ index:IndexPath,_ isMatch:Bool = false, _ type:String) -> SearchCourseCell {
    let cell = table.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
        switch table.tag {
        case 10:cell.configure(model: featureCourseList[index.row],isMatch: isMatch)
        default:cell.configure(model: perfectMatchCourseList[index.row],isMatch: isMatch)
        }
    cell.fevtBtn.tag = index.row
    cell.fevtBtn.addTarget(self, action: #selector(fevtBtnTapped), for: .touchUpInside)
    cell.universityName.tag = index.row
    cell.universityName.accessibilityLabel = type
    cell.fevtBtn.accessibilityLabel = type
    cell.universityName.addTarget(self, action: #selector(universityNameBtnTapped), for: .touchUpInside)
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
        if let labl = sender.accessibilityLabel,labl == "Perfect" {
            print(labl)
             let model = NewSearchCourseViewModel()
            model.perfectMatchAddRemoveFevt(self.perfectMatchCourseList[sender.tag])
             self.perfectMatchCourseList[sender.tag].isLike = !self.perfectMatchCourseList[sender.tag].isLike
            self.perfectTable.reloadData()
          return
        }
        
        let model = NewSearchCourseViewModel()
        model.featureAddRemoveFromFevt(self.featureCourseList[sender.tag])
        self.featureCourseList[sender.tag].isLike = !self.featureCourseList[sender.tag].isLike
        self.featureTable.reloadData()
    }
    
    @IBAction func universityNameBtnTapped(_ sender: UIButton){
        if let labl = sender.accessibilityLabel {
            if labl == "Perfect" {
                let model = self.perfectMatchCourseList[sender.tag]
                model.isShowCourse = false
                 model.isFromFeature = false
                self.moveToUniversityDetails(model)
                print(labl)
                return
            }
          print(labl)
            let model = self.featureCourseList[sender.tag]
            model.isShowCourse = false
            model.isFromFeature = true
            self.moveToUniversityDetails(model)
        }
    }
    
    func moveToUniversityDetails(_ model:SearchCoursesModel){
        if let vc                    = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                    vc.instituteID   = model.instituteId
                    vc.titleName     = model.instituteName
                    vc.isShowCourse  = model.isShowCourse
                    vc.courseId      = model.courseId
                    vc.isFormFeature = model.isFromFeature
                    self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    func clickMoreTapped() {
        
    }
}
