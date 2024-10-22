//
//  SearchCourseVC.swift
//  CampusFrance
//
//  Created by UNICA on 02/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SearchCourseVC: UIViewController {
   
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var collection:UICollectionView!
    @IBOutlet weak var searchHeightConst: NSLayoutConstraint!
    @IBOutlet var customView: UIView!
   
    @IBOutlet var matchBackView: UIView!
    @IBOutlet weak var matchLowerView: UIView!
    @IBOutlet var unMatchBackView: UIView!
    @IBOutlet weak var unMatchLowerView: UIView!
    @IBOutlet var matchBtn:UIButton!
    @IBOutlet var unmatchBtn:UIButton!
    @IBOutlet var menuHeightConstant: NSLayoutConstraint!
    @IBOutlet var whatsAppBtn: UIButton!
    @IBOutlet var callBtn:UIButton!
    var courseArray = [SearchCoursesModel]()
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
          CustomSearchView
       private var isFetchingNextPage = false
       var pagingCounter              = 1
       var isSearching = false
       var isSearchForMatch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
    
    func configure(){
        whatsAppBtn.titleLabel?.numberOfLines = 0
        whatsAppBtn.titleLabel?.textAlignment = .center
        whatsAppBtn.titleLabel?.lineBreakMode = .byWordWrapping
        callBtn.titleLabel?.numberOfLines     = 0
        callBtn.titleLabel?.textAlignment     = .center
        callBtn.titleLabel?.lineBreakMode     = .byWordWrapping
        whatsAppBtn.cornerRadius(10)
        callBtn.cornerRadius(10)
        matchLowerView.backgroundColor        = UIColor.clear
        unMatchLowerView.backgroundColor      = UIColor().hexStringToUIColor(hex: "343434")
        addLeftMenuBtnOnNavigation()
        gradientView.setGradientColor()
        configureTabs()
    }
    
    func configureTabs(){
        let model = UserModel.getObject().tabDetails
        menuHeightConstant.constant = 20
        matchBackView.isHidden      = true
        unMatchBackView.isHidden    = true
        if model.isShowTabs {
            menuHeightConstant.constant = 20
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    
    @IBAction func matchedBtnTapped(_ sender: Any) {
         searchView.searchtext.text = ""
         searchView.removeFromSuperview()
         isSearchForMatch = true
        matchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
        unMatchLowerView.backgroundColor = UIColor.clear
         let index = IndexPath(item: 1, section: 0)
        collection.scrollToItem(at: index, at: .right, animated: false)
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
    }
    
    @IBAction func unMatchedBtnTapped(_ sender: Any) {
         searchView.searchtext.text = ""
         searchView.removeFromSuperview()
        isSearchForMatch = false
        matchLowerView.backgroundColor =  UIColor.clear
        unMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
        let index = IndexPath(item: 0, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
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
    //    isSearching = true
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
        let searchBarBtn                                         = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem                  = searchBarBtn
    }
    
  
    @IBAction func whatsAppBtnTApped(_ sender: UIButton) {
        let what = AppSession.share.agentWhatsup
        if what.isEmpty == false {
        // openWhatsapp(what,"")
        }else{
        showAlertMsg(msg: "Whatsapp number is not present")
     }
    }
    
    @IBAction func callBtnTapped(_ sender:UIButton){
        let phone = AppSession.share.agentMobile
        if phone.isEmpty == false {
         //  callNumber(phoneNumber: phone)
        }else{
            showAlertMsg(msg: "Mobile number is not present")
        }
    }
}


//***********************************************//
// MARK: Search Protocol
//***********************************************//
extension SearchCourseVC:searchProtocol{
    func getSearchKeyword(keyWord: String) {
        if isSearchForMatch {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearch"), object: nil, userInfo:["key":keyWord])
        }else{
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearch"), object: nil, userInfo:["key":keyWord])
        }
        print("keyword for search in SearchCourseVC  is \(keyWord)")
    }
    func searchViewDismissed() {
        isSearching = false
        if isSearchForMatch {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
        }
    }
}


extension SearchCourseVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
           return matchCellWith(indexPath:indexPath, collectionView)
        }
        return featureCellWith(indexPath:indexPath, collectionView)
        default:return featureCellWith(indexPath:indexPath, collectionView)
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    
    func matchCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> MatchedCollectionCell{
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchedCollectionCell", for: indexPath) as! MatchedCollectionCell
        cell.delegate = self
        cell.layoutIfNeeded()
        cell.configure()
        
        return cell
    }
    
    func featureCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> SearchFeatureCollectionCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFeatureCollectionCell", for: indexPath) as! SearchFeatureCollectionCell
        cell.delegate = self
        cell.clickMoreProtocol = self
        cell.layoutIfNeeded()
        cell.configure()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        switch currentPage {
        case 0:
        matchLowerView.backgroundColor =   UIColor().hexStringToUIColor(hex: "343434")
        unMatchLowerView.backgroundColor = UIColor.clear
         isSearchForMatch = true
        searchView.removeFromSuperview()
        searchView.searchtext.text = ""
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
        
        default:
            matchLowerView.backgroundColor = UIColor.clear
                unMatchLowerView.backgroundColor = UIColor().hexStringToUIColor(hex: "343434")
             isSearchForMatch = false
            searchView.removeFromSuperview()
            searchView.searchtext.text = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
        }
    }
}

extension SearchCourseVC:clickMoreDelegate,unMatchedProtocol,MatchedProtocol{
    func courseDetailsTapped(with model: SearchCoursesModel) {
        model.isShowCourse = true
        self.moveToUniversityDetails(model)
    }
    
    func matchedCourseDetailsTapped(with model: SearchCoursesModel) {
        
    }
    
    func clickMoreTapped() {
        let anny = (Any).self
        self.matchedBtnTapped(anny)
    }
    func matchedUniversityNameTapped(with model: SearchCoursesModel) {
        self.moveToUniversityDetails(model)
    }
    func matchedCourseDetailsTapped(with courseId: String) {
        self.moveToCourseDetails(courseId)
    }
    func universityNameTapped(with model: SearchCoursesModel) {
        self.moveToUniversityDetails(model)
    }
    func courseDetailsTapped(with courseId: String) {
        self.moveToCourseDetails(courseId)
        
    }
}
 extension SearchCourseVC {
    func moveToCourseDetails(_ courseId: String){
       if  let vc = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsVC")as? CourseDetailsVC {
        vc.courseId = courseId
        self.navigationController!.pushViewController(vc, animated: false)
        }
    }
    
    func moveToUniversityDetails(_ model: SearchCoursesModel){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                    vc.instituteID = model.instituteId
                    vc.titleName = model.instituteName
                    vc.isShowCourse = model.isShowCourse
                    vc.courseId = model.courseId
                    self.navigationController?.pushViewController(vc, animated: true)
            }
    }
}






/*
import UIKit

class SearchCourseVC: UIViewController {
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var collection:UICollectionView!
    @IBOutlet weak var searchHeightConst: NSLayoutConstraint!
    @IBOutlet var customView: UIView!
    @IBOutlet var matchBackView: UIView!
    @IBOutlet weak var matchLowerView: UIView!
    @IBOutlet var unMatchBackView: UIView!
    @IBOutlet weak var unMatchLowerView: UIView!
    @IBOutlet var matchBtn:UIButton!
    @IBOutlet var unmatchBtn:UIButton!
    @IBOutlet var menuHeightConstant: NSLayoutConstraint!
    @IBOutlet var whatsAppBtn: UIButton!
    @IBOutlet var callBtn:UIButton!
    
    var courseArray                = [SearchCoursesModel]()
    var isSearchForMatch           = true
    private var isFetchingNextPage = false
    var pagingCounter              = 1
    var isSearching                = false
    var selectedFilter             = CountryModel()
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
       CustomSearchView
    
    
    var isFeatureFilterApplied      = false
    var isPerfectMatchFilterApplied = false
    var isFeatureFilterAvalible     = true
    var isPerfectFilterAvalible     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
    
    func configure(){
        whatsAppBtn.titleLabel?.numberOfLines = 0
        whatsAppBtn.titleLabel?.textAlignment = .center
        whatsAppBtn.titleLabel?.lineBreakMode = .byWordWrapping
        callBtn.titleLabel?.numberOfLines     = 0
        callBtn.titleLabel?.textAlignment     = .center
        callBtn.titleLabel?.lineBreakMode     = .byWordWrapping
        whatsAppBtn.cornerRadius(10)
        callBtn.cornerRadius(10)
        matchLowerView.backgroundColor = UIColor.clear
        unMatchLowerView.backgroundColor =  UIColor().themeColor()
        addLeftMenuBtnOnNavigation()
        gradientView.setGradientColor()
        configureTabs()
    }
    
    func configureTabs(){
        let model = UserModel.getObject().tabDetails
        if model.isShowTabs {
            menuHeightConstant.constant = 20
            if model.isMatchTitle {
                self.matchBtn.setTitle(model.matchTitle, for: .normal)
                menuHeightConstant.constant = 50
                matchBackView.isHidden = false
            }
            if model.isFeaturedTitle {
            self.unmatchBtn.setTitle(model.featuredTitle, for: .normal)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    
    @IBAction func matchedBtnTapped(_ sender: Any) {
         searchView.searchtext.text = ""
         searchView.removeFromSuperview()
         isSearchForMatch = true
        matchLowerView.backgroundColor = UIColor().themeColor()
        unMatchLowerView.backgroundColor = UIColor.clear
         let index = IndexPath(item: 1, section: 0)
        collection.scrollToItem(at: index, at: .right, animated: false)
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
    }
    
    @IBAction func unMatchedBtnTapped(_ sender: Any) {
         searchView.searchtext.text       = ""
         searchView.removeFromSuperview()
         isSearchForMatch                 = false
         matchLowerView.backgroundColor   =  UIColor.clear
         unMatchLowerView.backgroundColor = UIColor().themeColor()
        let index = IndexPath(item: 0, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
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
    //    isSearching = true
    }
    
  @IBAction func   filterBtnTapped(_ sender:UIButton){
      self.view.endEditing(true)
      if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryFilterVC") as? CountryFilterVC {
          vc.delegate        = self
          vc.country  = selectedFilter
          vc.isPerfectMatch = isPerfectFilterAvalible
          if let window = UIApplication.shared.keyWindow {
              window.rootViewController?.add(vc)
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
        
       let  filterButton                                        = UIButton(type: .custom)
        
                    filterButton.setImage(UIImage(named: "filter.png"), for: .normal)
                    
                    filterButton.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
                    filterButton.addTarget(self, action: #selector(filterBtnTapped), for: .touchUpInside)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        rightView.addSubview(searchButton)
               rightView.addSubview(filterButton)
               
               
        
        
        let leftBarBtn                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = leftBarBtn
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
}



extension SearchCourseVC{
    
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

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}


//***********************************************//
// MARK: Filter Protocol
//***********************************************//
extension SearchCourseVC:CountryFilterDelegate{
    func resetFeatureFilter() {
        self.isFeatureFilterApplied = false
        self.selectedFilter         = CountryModel()
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: searchList.searchResetFeatureFilter), object: nil, userInfo:nil)
    }
    
    func resetPerfectMatchFilter() {
        isPerfectMatchFilterApplied = false
        self.selectedFilter = CountryModel()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: searchList.searchResetPerfectFilter), object: nil, userInfo:nil)
    }
    
    func getFilterQueryFeature(_ country: CountryModel) {
        isFeatureFilterApplied = true
        self.selectedFilter = country
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: searchList.searchFilterApplied), object: nil, userInfo:["id":country.id])
    }
    
    func getFilterQueryPerfect(_ country: CountryModel) {
        isPerfectMatchFilterApplied = true
        self.selectedFilter = country
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: searchList.searchPerfectFilterApplied), object: nil, userInfo:["id":country.id])
    }
    
}

//***********************************************//
// MARK: Search Protocol
//***********************************************//
extension SearchCourseVC:searchProtocol{
    func getSearchKeyword(keyWord: String) {
        if isSearchForMatch {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearch"), object: nil, userInfo:["key":keyWord])
        }else{
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearch"), object: nil, userInfo:["key":keyWord])
        }
        print("keyword for search in SearchCourseVC  is \(keyWord)")
    }
    func searchViewDismissed() {
        isSearching = false 
        if isSearchForMatch {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
        }
    }
}


extension SearchCourseVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0 :return featureCellWith(indexPath:indexPath, collectionView)
        default:return matchCellWith(indexPath:indexPath, collectionView)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    
    func matchCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> MatchedCollectionCell{
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchedCollectionCell", for: indexPath) as! MatchedCollectionCell
        cell.delegate = self
        cell.layoutIfNeeded()
        cell.configure()
        
        return cell
    }
    
    func featureCellWith(indexPath:IndexPath,_ collectionView: UICollectionView)-> SearchFeatureCollectionCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFeatureCollectionCell", for: indexPath) as! SearchFeatureCollectionCell
        cell.delegate = self
        cell.moreDelegate = self
        cell.layoutIfNeeded()
        cell.configure()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        switch currentPage {
        case 0:matchLowerView.backgroundColor =  UIColor.clear
               unMatchLowerView.backgroundColor = UIColor().themeColor()
               isSearchForMatch = false
               searchView.removeFromSuperview()
               searchView.searchtext.text = ""
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "matchSearchDismissed"), object: nil, userInfo:nil)
        default:matchLowerView.backgroundColor = UIColor().themeColor()
                unMatchLowerView.backgroundColor = UIColor.clear
                isSearchForMatch = true
                searchView.removeFromSuperview()
                searchView.searchtext.text = ""
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unMatchSearchDismissed"), object: nil, userInfo:nil)
        }
    }
}

extension SearchCourseVC:clickMoreDelegate,unMatchedProtocol,MatchedProtocol{
    func clickMoreTapped() {
        let anny = (Any).self
        self.matchedBtnTapped(anny)
    }
    func matchedUniversityNameTapped(with model: SearchCoursesModel) {
        
        if let vc                           = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                             vc.instituteID = model.instituteId
                             vc.titleName   = model.instituteName
                            vc.isShowCourse = model.isShowCourse
                            vc.courseId     = model.courseId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func matchedCourseDetailsTapped(with courseId: String) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewCourseDetailsVC")as! NewCourseDetailsVC
        vc.courseId = courseId
        vc.isFormFeature = false
        self.navigationController!.pushViewController(vc, animated: false)
        
    }
    
    func universityNameTapped(with model: SearchCoursesModel) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
              vc.instituteID   = model.instituteId
              vc.titleName     = model.instituteName
              vc.isShowCourse  = model.isShowCourse
              vc.courseId      = model.courseId
              vc.isFormFeature = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func courseDetailsTapped(with courseId: String) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewCourseDetailsVC")as! NewCourseDetailsVC
        vc.courseId = courseId
        vc.isFormFeature = true
        self.navigationController!.pushViewController(vc, animated: false)
    }
}
*/


