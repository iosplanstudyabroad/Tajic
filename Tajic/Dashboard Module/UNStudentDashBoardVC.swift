//
//  UNStudentDashBoardVC.swift
//  Unica New
//
//  Created by UNICA on 04/10/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNStudentDashBoardVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var menuCollection:UICollectionView!
    
    var bannerArray             = [BannerModel]()
    var menuArray               = [MenuModel]()
    var eventMenuArray          = [SubMenuModel]()
    var eventCellHeight:CGFloat = 0.0
    var numberOfRows            = 2
    var documentArray           = [DocumentModel]()
    var unreadCount             = 0
    let coutLable               = UILabel()
    
    var isFromNotification      = false
    var menuIndex               = -1
    var colHeight:CGFloat       = 0.0
    
    var backGroundColorArray = [
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D",
    "D26C0B","960001","214987","457C7D"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func redircectMenuFromNotification(){
        if let index = UserDefaults.standard.object(forKey: "sIndex") as? Int {
            self.menuIndex = index
            UserDefaults.standard.removeObject(forKey:"sIndex")
        }
        if isFromNotification && self.menuIndex != -1 {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.menuArray.forEach { (menu) in
                    if menu.rowNumber == self.menuIndex {
                        self.moveToViewController(model: menu)
                    }
                }
            }
            AppSession.share.isForHomeRedirection = false
             isFromNotification = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        coutLable.isHidden = true
        initialSetup()
        AppSession.share.registerModel.countryList.removeAll()
        AppSession.share.multiCountryList.removeAll()
        AppSession.share.registerModel          = RegistrationModel()
        AppSession.share.isFirstLoad            = false
        AppSession.share.isFirstLoadSelect      = false
        AppSession.share.isfirsLoadSelectedExam = false
        AppSession.share.miniProfileModel       = MiniProfileModel()
       
        let model = StudentDashBoardViewModel()
        model.getDocumentsList { (docArray) in
                AppSession.share.documentArray.removeAll()
                self.documentArray             = docArray
                AppSession.share.documentArray = docArray
               }
        
        model.updateToken { (dict) in
            print("Update token Response/(dict)")
        }
        
        model.getAppConfigurationDetails { (dict) in
                let uModel = UserModel.getObject()
                if let id = dict["app_agent_id"] as? String {
                  uModel.agentId = id
                }
               if let id = dict["app_agent_id"] as? Int {
                uModel.agentId = String(id)
            }
            if let courseDict = dict["course_tabs"] as? [String:Any]{
                let tabModel = CourseTabModel(courseDict)
              uModel.tabDetails = tabModel
            }
            uModel.profileCompleted = "Y"
            uModel.saved()
        }
        
        model.unreadCount { (count) in
            if count > 0 {
            self.unreadCount = count
                if self.unreadCount > 0 &&  self.unreadCount < 10 {
                   self.coutLable.isHidden = false
                   self.coutLable.text = String(self.unreadCount)
                       }
                       if self.unreadCount > 0 &&  self.unreadCount > 10 {
                          self.coutLable.isHidden = false
                        self.coutLable.text =  "10+"
                       }
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    func configure(){
        tableHeight.constant = 200 //(UIScreen.main.bounds.height/2.5)-90
        isFromNotification = AppSession.share.isForHomeRedirection
        redircectMenuFromNotification()
        setupNavigation()
        setupDashBoard()
    }
    
    func setupDashBoard(){
        let model = StudentDashBoardViewModel()
        model.getMenu { (menus) in
            self.setupMenus(menus: menus, model: model)
        }
        
        model.getBanners { (banners) in
            self.setupBanners(banners: banners)
               }
        
        if StaticHelper.isInternetConnected == false{
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                model.getSavedMenuData() { (menus) in
            self.setupMenus(menus: menus.menuList,model:model)
              }
            }
            
            model.getOfflineBanners { (banners) in
            self.setupBanners(banners: banners)
               }
        }
    }
    func setupBanners(banners:[BannerModel]){
        self.bannerArray = banners
        self.table.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    func setupMenus(menus:[MenuModel],model:StudentDashBoardViewModel){
        if menus.isEmpty == false {
            self.menuArray = menus.sorted(by: { $1.dashBoardOrder > $0.dashBoardOrder })
//            self.eventCellHeight = model.calculateHeight(menus)
            DispatchQueue.main.async {
                self.menuCollection.reloadData()
            }
        }
    }
    func saveQrCode(){
        let model = StudentQRCodeViewModel()
        model.getQrDetail {(_,_)in}
    }
    
    func initialSetup(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.table.reloadData()
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func leftmenuBtnTapped(_ sender: Any) {
        if let menu = self.slideMenuController() {
            menu.openLeft()
        }
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func chatBtnTapped(_ sender: Any){}
   
    @IBAction func notificationBtnTapped(_ sender: Any){
     if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC {
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension UNStudentDashBoardVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "Menu.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(leftmenuBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-120, height: 45))
        leftView.backgroundColor = .clear
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 45))
        
        titleLbl.text = "Home"
        
        /* if UserModel.getObject().firstname.isEmpty {
         titleLbl.text = "Home"
        }else{
           let name =  UserModel.getObject().firstname
            let lastName = UserModel.getObject().lastname
            titleLbl.text = "\(name) \(lastName)"
        }
        */
        
        titleLbl.textColor = UIColor.white
        titleLbl.font = .systemFont(ofSize: 18)
        
        
       
        let xAxis  = (leftView.frame.size.width/2) 
        
        leftView.addSubview(titleLbl)
        let logoImage = UIImageView(image: UIImage(named: "text-logo"))
        logoImage.frame = CGRect(x: xAxis, y: 0, width: 100, height: 45)
       // leftView.addSubview(logoImage)
        
        let rightView = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 45))
        let chatBtn = UIButton(type: .custom)
      //  chatBtn.setImage(UIImage(named: "bell.png"), for: .normal)
       // chatBtn.addTarget(self, action: #selector(chatBtnTapped), for: .touchUpInside)
        chatBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        
        rightView.addSubview(chatBtn)
        let rightMenuBtn                                        = UIButton(type: .custom)
        rightMenuBtn.setImage(UIImage(named: "bell.png"), for: .normal)
        rightMenuBtn.addTarget(self, action: #selector(notificationBtnTapped), for: .touchUpInside)
        rightMenuBtn.frame = CGRect(x: 50, y: 0, width: 45, height: 45)
        coutLable.font = UIFont.systemFont(ofSize: 12)
        coutLable.textColor = UIColor.white
        coutLable.textAlignment = .center
    coutLable.backgroundColor = UIColor.red
        coutLable.frame  = CGRect(x: 70, y: 0, width: 25, height: 25)
        coutLable.cornerRadius(13)
        coutLable.border(1, borderColor: UIColor.red)
        rightView.addSubview(rightMenuBtn)
        rightView.addSubview(coutLable)

        let unreadLabl = UILabel()
        unreadLabl.frame = CGRect(x: 20, y: 0, width: 26, height: 26)
        unreadLabl.textColor           = UIColor.clear
        unreadLabl.backgroundColor     = UIColor.clear
        rightView.addSubview(unreadLabl)
        let rightBarBtn                                         = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem                  = rightBarBtn
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
        
        navigationConfigure()
    }
    
    func navigationConfigure(){
        if #available(iOS 13.0, *) {
            guard let navigation = self.navigationController else { return }
            
            let navBarAppearance = UINavigationBarAppearance()
                    navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor:UIColor.barTintColor]
            
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.barTintColor]
            navBarAppearance.backgroundColor = .barTintColor

            navBarAppearance.backgroundImage = nil
            
            
            navBarAppearance.shadowImage = nil
            navBarAppearance.shadowColor = nil
            
            navigation.navigationBar.standardAppearance = navBarAppearance
            navigation.navigationBar.compactAppearance = navBarAppearance
            navigation.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigation.navigationBar.prefersLargeTitles = false
            navigation.navigationBar.isTranslucent = false
            //navigation.navigationBar.tintColor = UIColor().barTintColor()
            //navigationItem.title = title
            

            
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}
extension UNStudentDashBoardVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 200
            //(UIScreen.main.bounds.height/3.0) //- 100
        default: return eventCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:return configureBannerCellWith(tableView, cellForRowAt: indexPath)
        default: return configureMenuWith(tableView, cellForRowAt: indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let dashCell = cell as? UNAgentBannerCell {
               dashCell.setTimer()
           }
       }
       func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let dashCell = cell as? UNAgentBannerCell {
               dashCell.disableTimer()
           }
       }
    
    
}

extension UNStudentDashBoardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgentMenuCollectionCell", for: indexPath) as! UNAgentMenuCollectionCell
        if menuArray.isEmpty == false {
            cell.configure(menuArray[indexPath.row],index: indexPath.row)
        }
        
        
    //  cell.setColor(hex: backGroundColorArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.size.width - 10
        let size = CGSize(width: width/2, height: width/3)
        return size
        
        
        
        if menuArray.isEmpty {
            return CGSize(width: 100, height: 100)
        }else {
            let width = collectionView.frame.size.width
             colHeight = collectionView.frame.size.height/(CGFloat(menuArray.count)/4.0)
            //let size = CGSize(width: width/2.0, height:  width/4  )
            let screen = UIScreen.main.bounds.width - 15
            let widthh = collectionView.frame.size.width - 10
            let size = CGSize(width: screen/2, height: screen/2)//128
            
            print("All rows last row \(size)")
          /*
            print("Menu Index \(menuArray[indexPath.item])")
            */
            return size
        }
        let itemCount = indexPath.item+1
        //if menuArray.count == itemCount &&
        
        
        if menuArray.count%2 != 0  {
            let width = collectionView.frame.size.width - 10
            print("Count:- \(self.menuArray.count),\(itemCount)")
            print("last index:- \(menuArray[indexPath.item].leftMenuTitle)")
            
            colHeight = collectionView.frame.size.height/(CGFloat(menuArray.count+1)/2.0)
            let size = CGSize(width: width/2, height: colHeight - 10)
            print("Size last row \(size)")
            return size
        }else {
            let width = collectionView.frame.size.width - 10
             colHeight = collectionView.frame.size.height/(CGFloat(menuArray.count)/2.0)
            let size = CGSize(width: width/2, height: colHeight - 10 )
            print("All rows last row \(size)")
          /*
            print("Menu Index \(menuArray[indexPath.item])")
            */
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToViewController(model: menuArray[indexPath.item])
        
    }
    }


extension UNStudentDashBoardVC{
    private func configureBannerCellWith(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UNAgentBannerCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentBannerCell") as! UNAgentBannerCell
        cell.configure(self.bannerArray)
        return cell
    }
    private func configureMenuWith(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UNAgentMenuCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentMenuCell") as! UNAgentMenuCell
        cell.delegate = self
        cell.configure(self.menuArray,nil)
        return cell
    }
}

extension UNStudentDashBoardVC:agentMenuProtocol{
    func getTappedMenuDetails(model: MenuModel) {
       moveToViewController(model: model)
    }
    
    func moveToViewController(model:MenuModel){
           switch model.rowNumber {
           case 2:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
           if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
               nav.pushViewController(vc, animated: true)
           }}
               case 3:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
               
               if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewSearchCourseVC") as? NewSearchCourseVC {
                   nav.pushViewController(vc, animated: true)
               }}//YourApplicationVC
               case 4:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
               if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourApplicationVC") as? YourApplicationVC {
                vc.pageTitle = model.leftMenuTitle
                   nav.pushViewController(vc, animated: true)
               }}
               case 5:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                          if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShortListVC") as? ShortListVC {
                            
                            vc.pageTitle = model.leftMenuTitle
                              nav.pushViewController(vc, animated: true)
                          }}
            case 6:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                  if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendVC") as? ReferFriendVC {
                            nav.pushViewController(vc, animated: true)
                         }
            }
            case 7:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is CountryOfStudyVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryOfStudyVC") as? CountryOfStudyVC {
                vc.pageTitle  = model.leftMenuTitle
                nav.pushViewController(vc, animated: true)
            }}
            
            case 8:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReachUsVC") as? ReachUsVC {
                nav.pushViewController(vc, animated: true)
            }}
            
            case 9:let  filterArray = self.documentArray.filter{(dModel) -> Bool in
                (dModel.isUploaded) == true
            }
            if filterArray.isEmpty {
                moveToNoDocuments()
            }else{
               moveToDocumentList()
            }
//            case 10: if model.linkOpenType == "Web" {
//                commonWeb(model:model)
//            }
            case 11:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is CountryOfStudyVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LatestEventsVC") as? LatestEventsVC {
                vc.pageTitile = model.leftMenuTitle
                nav.pushViewController(vc, animated: true)
            }}
               
           case 15: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
          
           if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobAbroadVC") as? JobAbroadVC {
               nav.pushViewController(vc, animated: true)
           }}
               
     default:if model.linkOpenType == "Web" {
         commonWeb(model:model)
     }
           }
    }
    
    func commonWeb(model:MenuModel){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
            vc.titleString = model.leftMenuTitle
            vc.urlString = model.url
            nav.pushViewController(vc, animated: true)
            }}
    }
    

    func moveToNoDocuments(){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is DocumentsVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentsVC") as? DocumentsVC {
           
            nav.pushViewController(vc, animated: true)
        }
        }
    }
    func moveToDocumentList(){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is DocumentsListVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentsListVC") as? DocumentsListVC {
             vc.documentList = documentArray
            nav.pushViewController(vc, animated: true)
        }
        }
    }
}
