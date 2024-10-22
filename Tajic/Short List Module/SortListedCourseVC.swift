//
//  SortListedCourseVC.swift
//  CampusFrance
//
//  Created by UNICA on 01/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SortListedCourseVC: UIViewController {
    @IBOutlet weak var noRecordTest: UILabel!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var fevtLowerView:UIView!
    @IBOutlet weak var  intLowerView:UIView!
    @IBOutlet weak var  collection:UICollectionView!
    
    let searchView = Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)![0] as!
    CustomSearchView
    
    var searchKeyWord      = ""
    var isSearchForFevt = false
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        addLeftMenuBtnOnNavigation()
        gradientView.setGradientColor()
        fevtLowerView.backgroundColor = UIColor().selectionColor()
        intLowerView.backgroundColor = UIColor.clear
        isSearchForFevt = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func menuBtnTapped(_ sender: Any) {
        if AppSession.share.isFormNotification {
           
            AppSession.share.isFormNotification =  false 
            AppDelegate.shared.setRootViewController(vc: .Home)
            return
        }
        self.slideMenuController()?.openLeft()
        
    }
    
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
        titleLbl.text = "Shortlisted Courses"
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
    // MARK: New Implementations
    //***********************************************//
    
    
    @IBAction func fevtListBtnTapped(_ sender: Any) {
        searchView.searchtext.text = ""
        searchView.removeFromSuperview()
        isSearchForFevt = true
        fevtLowerView.backgroundColor = UIColor().selectionColor()
        intLowerView.backgroundColor = UIColor.clear
        let index = IndexPath(item: 0, section: 0)
        collection.scrollToItem(at: index, at: .right, animated: false)
        collection.reloadItems(at: [index])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.fevtSearchDismissed.rawValue), object: nil, userInfo:nil)
    }
    
    
    @IBAction func intListBtnTapped(_ sender: Any) {
        searchView.searchtext.text = ""
        searchView.removeFromSuperview()
        isSearchForFevt = false
        fevtLowerView.backgroundColor =  UIColor.clear
        intLowerView.backgroundColor = UIColor().selectionColor()
        let index = IndexPath(item: 1, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
        collection.reloadItems(at: [index])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.intSearchDismissed.rawValue), object: nil, userInfo:nil)
    }
    
    
    
    
    
}
//***********************************************//
// MARK: Search Protocol
//***********************************************//

//***********************************************//
// MARK: Search Protocol
//***********************************************//
extension SortListedCourseVC:searchProtocol{
    func getSearchKeyword(keyWord: String) {
        if isSearchForFevt {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.fevtSearch.rawValue), object: nil, userInfo:["key":keyWord])
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.intSearch.rawValue), object: nil, userInfo:["key":keyWord])
        }
        print("keyword for search in SearchCourseVC  is \(keyWord)")
    }
    func searchViewDismissed() {
        isSearching = false
        if isSearchForFevt {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.fevtSearchDismissed.rawValue), object: nil, userInfo:nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.intSearchDismissed.rawValue), object: nil, userInfo:nil)
        }
    }
}

 








extension SortListedCourseVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:return FevtCollectionCell(indexPath:indexPath, collectionView)
        default: return InterestedCollectionCell(indexPath:indexPath, collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    
    func InterestedCollectionCell(indexPath:IndexPath,_ collectionView: UICollectionView)-> SortIntCollectionCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SortIntCollectionCell", for: indexPath) as! SortIntCollectionCell
        cell.delegate = self
       cell.configure()
        return cell
    }
    
    func FevtCollectionCell(indexPath:IndexPath,_ collectionView: UICollectionView)-> SortFevtCollectionCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SortFevtCollectionCell", for: indexPath) as! SortFevtCollectionCell
       cell.delegate = self
      cell.configure()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        switch currentPage {
        case 0:  fevtLowerView.backgroundColor = UIColor().selectionColor()
         intLowerView.backgroundColor = UIColor.clear
        isSearchForFevt = true
        searchView.removeFromSuperview()
        searchView.searchtext.text = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.intSearchDismissed.rawValue), object: nil, userInfo:nil)
        let index = IndexPath(item: 0, section: 0)
        collection.scrollToItem(at: index, at: .left, animated: false)
        default:
            fevtLowerView.backgroundColor =  UIColor.clear
             intLowerView.backgroundColor = UIColor().selectionColor()
            isSearchForFevt = false
            searchView.removeFromSuperview()
            searchView.searchtext.text = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: sortNotification.fevtSearchDismissed.rawValue), object: nil, userInfo:nil)
            let index = IndexPath(item: 1, section: 0)
            collection.scrollToItem(at: index, at: .left, animated: false)
        }
    }
}


extension SortListedCourseVC:SortFevtProtocol,SortIntProtocol{
   
    
   
    
    
    
    func fevtUniversityNameTapped(with model: SearchCoursesModel) {
  
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                vc.instituteID = model.id
                vc.titleName = model.courseTitle
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
        
        
    /*

        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ParticipantDetailsVC")as! ParticipantDetailsVC
            let mode             = AvailableInstituteModel()
            mode.name            = model.courseTitle
            mode.id              = model.instituteId
            mode.participantId   = model.participantId
            mode.participantType = model.participantType
            mode.address         = ""
            mode.city            = ""
            mode.instituteName   = model.instituteName
            mode.state           = ""
            mode.aboutInstitute  = ""
            mode.slotDate        = ""
            mode.slotNumber      = ""
            vc.fillModel         = mode
            nav.pushViewController(vc, animated: false)
           */
           
        }
       
    
    
    func fevtCourseDetailsTapped(with courseId: String) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
        vc.courseId = courseId
        self.navigationController!.pushViewController(vc, animated: false)
        
    }
   
    func sortIntUniversityNameTapped(with model: SearchCoursesModel) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstituteBaseVC") as? InstituteBaseVC {
                      vc.instituteID = model.id
                      vc.titleName = model.courseTitle
                      self.navigationController?.pushViewController(vc, animated: true)
                  }
      /*
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ParticipantDetailsVC")as! ParticipantDetailsVC
        let mode = AvailableInstituteModel()
        mode.name = model.courseTitle
        mode.id = model.instituteId
        mode.participantId = model.participantId
        mode.participantType = model.participantType
        mode.address = ""
        mode.city = ""
        mode.instituteName = model.instituteName
        mode.state = ""
        mode.aboutInstitute = ""
        mode.slotDate = ""
        mode.slotNumber = ""
        vc.fillModel = mode
        self.navigationController!.pushViewController(vc, animated: false)
      */
    }
    
    func sortIntCourseDetailsTapped(with courseId: String) {
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
        vc.courseId = courseId
        self.navigationController!.pushViewController(vc, animated: false)
    }
    
  
    
    
    
    
    
//
//    func courseDetailsTapped(with courseId: String) {
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsVC")as! CourseDetailsVC
//        vc.courseId = courseId
//        self.navigationController!.pushViewController(vc, animated: false)
//
//    }


}
