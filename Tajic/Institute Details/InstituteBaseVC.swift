//
//  InstituteBaseVC.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import Parchment

class InstituteBaseVC: UIViewController {
    @IBOutlet weak var supportView:UIView!
    @IBOutlet weak var instIMage:UIImageView!
    var vcontrollersArray = [UIViewController]()
    var pageController:FixedPagingViewController!
    var model             = InstituteDetailsModel()
    var instituteID       = ""
    var titleName         = ""
    var isFormFeature     = false
    var courseId          = ""
    var isShowCourse      =  false
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
          }
    func configure(){
                addLeftMenuBtnOnNavigation()
                getDetails()
    }
    
    func configureVC(){
        let width = UIScreen.main.bounds.width/3
        if let vcArray  = controllers() {
            vcontrollersArray = vcArray
            pageController = FixedPagingViewController(viewControllers:vcArray)
            pageController.dataSource              = self
            pageController.delegate                = self
            pageController.selectedTextColor       = .white
            pageController.textColor               = .white //UIColor().themeColor()
            pageController.selectedBackgroundColor = .barTintColor
            pageController.backgroundColor         = .barTintColor
            pageController.indicatorColor          = .white
            
            pageController.menuItemSize = .fixed(width: width, height: 40)
            if isFormFeature {
             let width = UIScreen.main.bounds.width/2
             pageController.menuItemSize = .fixed(width: width, height: 40)
            }
            addChild(pageController)
            supportView.addSubview(pageController.view)
           
            
            pageController.view.translatesAutoresizingMaskIntoConstraints = false
                
            NSLayoutConstraint.activate([
                  pageController.view.topAnchor.constraint(equalTo: supportView.topAnchor),
                  pageController.view.bottomAnchor.constraint(equalTo: supportView.bottomAnchor),
                  pageController.view.leadingAnchor.constraint(equalTo: supportView.leadingAnchor),
                  pageController.view.trailingAnchor.constraint(equalTo: supportView.trailingAnchor),
            ])
            
            if isShowCourse {
                if isFormFeature {
                    DispatchQueue.main.async {
                        self.pageController.select(index: 1)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.pageController.select(index: 2)
                    }
                }
            }
         
          //  supportView.constrainToEdges(pageController.view)
            pageController.didMove(toParent: self)
        }
    }
    
    
    @IBAction func menuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDetails(){
        let model = InstituteViewModel()
        if  isFormFeature  {
            model.featrueInstituteDetails(instituteID) { (model) in
            self.model = model
            self.setImage(imageURL: model.image)
             self.configureVC()
            }
            
        }else{
         model.instituteDetails(instituteID) { (model) in
            self.model = model
            self.setImage(imageURL: model.image)
            DispatchQueue.main.async {
              self.configureVC()
            }
            }
        }
        
    }
    
    func setImage(imageURL:String){
        if imageURL.isEmpty == false && imageURL.isValidURL == true, let url = URL(string:imageURL ) {
            self.instIMage.sd_setImage(with:url , completed: nil)
        }
    }
}


extension InstituteBaseVC {
func addLeftMenuBtnOnNavigation(){
    self.navigationController?.configureNavigation()
    let button                            = UIButton(type: .custom)
    button.setImage(UIImage(named: "arrow_left.png"), for: .normal)
    button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
    button.frame                          = CGRect(x: 0, y: 0, width: 45, height: 45)
    let leftView                          = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 50 , height: 45))
    leftView.addSubview(button)
    let titleLbl                          = UILabel(frame: CGRect(x: 55, y: 0, width: self.view.frame.size.width - 50, height: 45))
    titleLbl.text                         = "Institution Details"//titleName
    titleLbl.textColor                    = UIColor.white
    leftView.addSubview(titleLbl)
    let barButton                         = UIBarButtonItem(customView: leftView)
    self.navigationItem.leftBarButtonItem = barButton
}
}
extension  InstituteBaseVC{
    func controllers()->[UIViewController]?{
        var vcArray = [UIViewController]()
        if let about = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteAboutVC") as? InstituteAboutVC {
            about.model = self.model
            vcArray.append(about)
        }
        if isFormFeature == false {

            if let info = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteInfoVC") as? InstituteInfoVC {
                info.model = self.model
                vcArray.append(info)
            }
        }
        
//        if let video = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteVideoVC") as? InstituteVideoVC {
//            video.model = self.model
//            vcArray.append(video)
//        }
        
        if let courseDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewCourseDetailsVC") as? NewCourseDetailsVC {
            courseDetails.courseId = self.courseId
            courseDetails.isFormFeature = self.isFormFeature
             vcArray.append(courseDetails)
            }
        
        
        
        //NewCourseDetailsVC
        
        if vcArray.isEmpty {
            return nil
        }
        return vcArray
    }
}
extension InstituteBaseVC:PagingViewControllerDelegate{
  /*func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
    guard let item = pagingItem as? PagingIndexItem else { return 0 }
    let insets     = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let size       = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
    let attributes = [NSAttributedString.Key.font: pagingViewController.font]
    let rect       = item.title.boundingRect(with: size,
      options: .usesDeviceMetrics,
      attributes: attributes,
      context: nil)
    let width      = ceil(rect.width) + insets.left + insets.right
    if isSelected {
      return width * 1.5
    } else {
      return width
    }
  }
    */
}
extension InstituteBaseVC: PagingViewControllerDataSource {
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: vcontrollersArray[index].title!) as! T
  }
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
    populateData(index)
    return vcontrollersArray[index]
  }
  
  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
    return vcontrollersArray.count
  }
}
extension InstituteBaseVC {
    func populateData(_ index:Int){
        if let vc = vcontrollersArray[index] as? InstituteAboutVC {
               vc.model = self.model
           }
        if let vc = vcontrollersArray[index] as? InstituteInfoVC {
               vc.model = self.model
           }
//        if let vc = vcontrollersArray[index] as? InstituteVideoVC {
//               vc.model = self.model
//           }
//
        
       if let vc = vcontrollersArray[index] as? NewCourseDetailsVC {
        vc.courseId = self.courseId//self.model.id
        vc.isFormFeature = self.isFormFeature
       }
        
        
    }
}







/*UIViewController {
    @IBOutlet weak var supportView:UIView!
    @IBOutlet weak var instIMage:UIImageView!
    var vcontrollersArray = [UIViewController]()
    var pageController:FixedPagingViewController!
    var model = InstituteDetailsModel()
    var instituteID = ""
    var titleName  = ""
    var isFormFeature   = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
          }
    func configure(){
                addLeftMenuBtnOnNavigation()
                getDetails()
    }
    
    func configureVC(){
        if let vcArray  = controllers() {
            vcontrollersArray = vcArray
            let width = UIScreen.main.bounds.width/3
        pageController = FixedPagingViewController(viewControllers:vcArray)
            pageController.dataSource              = self
            pageController.delegate                = self
//            pageController.selectedTextColor       = .white
//            pageController.textColor               = UIColor().themeColor()
//            pageController.selectedBackgroundColor = UIColor().themeColor()
            
            
            pageController.selectedTextColor       = .white
                       pageController.textColor               = .white //UIColor().themeColor()
                       pageController.selectedBackgroundColor = UIColor().themeColor()
                       pageController.backgroundColor         = UIColor().themeColor()
                       
                       pageController.menuItemSize = .fixed(width: width, height: 40)
            addChild(pageController)
            supportView.addSubview(pageController.view)
           
            
            pageController.view.translatesAutoresizingMaskIntoConstraints = false
                
            NSLayoutConstraint.activate([
                  pageController.view.topAnchor.constraint(equalTo: supportView.topAnchor),
                  pageController.view.bottomAnchor.constraint(equalTo: supportView.bottomAnchor),
                  pageController.view.leadingAnchor.constraint(equalTo: supportView.leadingAnchor),
                  pageController.view.trailingAnchor.constraint(equalTo: supportView.trailingAnchor),
            ])
            
            
         
          //  supportView.constrainToEdges(pageController.view)
            pageController.didMove(toParent: self)
        }
    }
    
    
    @IBAction func menuBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDetails(){
        let model = InstituteViewModel()
        if  isFormFeature  {
            model.featrueInstituteDetails(instituteID) { (model) in
            self.model = model
            self.setImage(imageURL: model.image)
             self.configureVC()
            }
            
        }else{
         model.instituteDetails(instituteID) { (model) in
            self.model = model
            self.setImage(imageURL: model.image)
             self.configureVC()
            }
        }
        
    }
    
    func setImage(imageURL:String){
        if imageURL.isEmpty == false && imageURL.isValidURL == true, let url = URL(string:imageURL ) {
            self.instIMage.sd_setImage(with:url , completed: nil)
        }
    }
}


extension InstituteBaseVC {
func addLeftMenuBtnOnNavigation(){
    self.navigationController?.configureNavigation()
    let button                            = UIButton(type: .custom)
    button.setImage(UIImage(named: "arrow_left.png"), for: .normal)
    button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
    button.frame                          = CGRect(x: 0, y: 0, width: 45, height: 45)
    let leftView                          = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 50 , height: 45))
    leftView.addSubview(button)
    let titleLbl                          = UILabel(frame: CGRect(x: 55, y: 0, width: self.view.frame.size.width - 50, height: 45))
    titleLbl.text                         = "Details"
    titleLbl.textColor                    = UIColor.white
    leftView.addSubview(titleLbl)
    let barButton                         = UIBarButtonItem(customView: leftView)
    self.navigationItem.leftBarButtonItem = barButton
}
}
extension  InstituteBaseVC{
    func controllers()->[UIViewController]?{
        var vcArray = [UIViewController]()
        if let about = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteAboutVC") as? InstituteAboutVC {
            about.model = self.model
            vcArray.append(about)
        }
        if let info = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteInfoVC") as? InstituteInfoVC {
            info.model = self.model
            vcArray.append(info)
        }
        
        if let video = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteVideoVC") as? InstituteVideoVC {
            video.model = self.model
            vcArray.append(video)
        }
        if let courses = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstituteCoursesVC") as? InstituteCoursesVC {
            courses.model = self.model
            courses.isFromFeature = isFormFeature
          //  vcArray.append(courses)
        }
        if vcArray.isEmpty {
            return nil
        }
        return vcArray
    }
}
extension InstituteBaseVC:PagingViewControllerDelegate{
    /*
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
    return nil
    guard let item = pagingItem as? PagingIndexItem else { return 0 }
    let insets     = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let size       = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
    let attributes = [NSAttributedString.Key.font: pagingViewController.font]
    let rect       = item.title.boundingRect(with: size,
      options: .usesDeviceMetrics,
      attributes: attributes,
      context: nil)
    let width      = ceil(rect.width) + insets.left + insets.right
    if isSelected {
      return width * 1.5
    } else {
      return width
    }
  }
    
    
    
    
    */
}
extension InstituteBaseVC: PagingViewControllerDataSource {
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: vcontrollersArray[index].title!) as! T
  }
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
    populateData(index)
    return vcontrollersArray[index]
  }
  
    
  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
    return vcontrollersArray.count
  }
}
extension InstituteBaseVC {
    func populateData(_ index:Int){
        if let vc = vcontrollersArray[index] as? InstituteAboutVC {
            vc.model = self.model
        }
        
        if let vc = vcontrollersArray[index] as? InstituteAboutVC {
               vc.model = self.model
           }
        
        if let vc = vcontrollersArray[index] as? InstituteInfoVC {
               vc.model = self.model
           }
        if let vc = vcontrollersArray[index] as? InstituteVideoVC {
               vc.model = self.model
           }
        if let vc = vcontrollersArray[index] as? InstituteCoursesVC {
               vc.model = self.model
           }
    }
}
*/
