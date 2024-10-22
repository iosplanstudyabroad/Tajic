//
//  UNStudentLeftMenuVC.swift
//  Unica New
//
//  Created by UNICA on 04/10/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class UNStudentLeftMenuVC: UIViewController {
    @IBOutlet weak var backImage:UIImageView!
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userEmail:UILabel!
    @IBOutlet weak var table:UITableView!
    var selectedIndex = 0
    var mainHeaderView = UIView()
     var menuArray = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let array = AppSession.share.menuArray
        self.menuArray =   array //.sorted(by: { $1.leftMenuOrder > $0.leftMenuOrder })
       
        
        table.reloadData()
        
        if UserModel.getObject().id.isEmpty == false {
            let model =   UserModel.getObject()
            userName.text = model.firstname + " "  + model.lastname
            userEmail.text = model.email
            if model.profileImage.isEmpty == false && model.profileImage.isValidURL == true, let url = URL(string: model.profileImage) {
                backImage.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
                
                userImage.sd_setImage(with: url, placeholderImage: nil, options: [], context: nil)
            }
        }
    }
    func configure(){
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 50
        blur()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func blur(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = (backImage.bounds)
        blurEffectView.alpha = 0.6
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       backImage.addSubview(blurEffectView)
    }
    
    
    @IBAction func userImageTapped(_ sender:UIButton){
        defer {
            redirectToProfile()
            /*
            if let controller = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ShowImageVC") as? ShowImageVC {
                if let img = userImage.image {
                    controller.currentImage = img
                }
                controller.remove()
              let view =   AppDelegate.shared.window!.rootViewController!.view
                UIView.transition(with: view!, duration:2.0, options: .curveEaseOut, animations: {
                    AppDelegate.shared.window?.rootViewController?.add(controller)
                }, completion: nil)
            }
            */
        }
         slideMenuController()?.closeLeft()
    }
    
    func redirectToProfile(){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentEditUserProfileVC") as? StudentEditUserProfileVC {
            nav.pushViewController(vc, animated: true)
            }
        }
    }
}
extension UNStudentLeftMenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            if  self.menuArray[indexPath.row].subMenu.isEmpty == false {
                let count = AppSession.share.menuArray[indexPath.row].subMenu.count + 1
                return CGFloat(count*50)
            }
        }
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentLeftMenuCell") as! UNAgentLeftMenuCell
       // cell.delegate = self
        cell.configure(model: self.menuArray[indexPath.row], isSelected: indexPath.row == selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let array = self.menuArray[indexPath.row].subMenu
        print(array)
        
            let model = self.menuArray[indexPath.row]
           
        selectedIndex = indexPath.row
        let index = IndexPath(row: selectedIndex, section: 0)
        
        tableView.reloadRows(at: [index], with: .automatic)
         self.moveToViewController(model:model)
    }
}
/*
extension UNStudentLeftMenuVC:subMenuProtocol {
    func getSelectedSubModel(model: SubMenuModel) {
        if model.linkOpenType == "Web" {
            if  model.url.isEmpty == false &&  model.url.isValidURL {
                if let url = URL(string: model.url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return
        }
        print(model.leftMenuTitle," ", model.rowNumber," ",model.url)
    }
}
*/
extension UNStudentLeftMenuVC {
    func moveToViewController(model:MenuModel){
        defer {
            slideMenuController()?.closeLeft()
        }
        switch model.rowNumber {
        case 1:print("Home Tapped")
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            nav.popToRootViewController(animated: true)
            return
            }
        case 2:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is ProfileVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            nav.pushViewController(vc, animated: true)
        }}
            case 3:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is SearchCourseVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchCourseVC") as? SearchCourseVC {
                nav.pushViewController(vc, animated: true)
            }}//YourApplicationVC
            case 4:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is YourApplicationVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourApplicationVC") as? YourApplicationVC {
                vc.pageTitle = model.leftMenuTitle
                nav.pushViewController(vc, animated: true)
            }}
            case 5:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                       if nav.topViewController is SortListedCourseVC {
                           return
                       }
                       if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShortListVC") as? ShortListVC {
                        vc.pageTitle = model.leftMenuTitle
                           nav.pushViewController(vc, animated: true)
                       }}
            
            case 6:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                                  if nav.topViewController is ReferFriendVC {
                                      return
                                  }
                                  if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendVC") as? ReferFriendVC {
                                      nav.pushViewController(vc, animated: true)
                                  }}
            case 7:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                       if nav.topViewController is CountryOfStudyVC {
                           return
                       }
                       if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryOfStudyVC") as? CountryOfStudyVC {
                        vc.pageTitle  = model.leftMenuTitle
                           nav.pushViewController(vc, animated: true)
                       }}
            
        case 8:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is ReachUsVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReachUsVC") as? ReachUsVC {
            nav.pushViewController(vc, animated: true)
        }}
        
            case 9:let  filterArray = AppSession.share.documentArray.filter{(dModel) -> Bool in
                (dModel.isUploaded) == true
            }
            if filterArray.isEmpty {
                moveToNoDocuments()
            }else{
               moveToDocumentList()
            }
            
            case 11:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is CountryOfStudyVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LatestEventsVC") as? LatestEventsVC {
                vc.pageTitile = model.leftMenuTitle
                nav.pushViewController(vc, animated: true)
            }}
            
            case 12:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is GeneralInfoVC {
                return
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GeneralInfoVC") as? GeneralInfoVC {
                nav.pushViewController(vc, animated: true)
            }}
        case 13: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is SettingVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as? SettingVC {
            nav.pushViewController(vc, animated: true)
        }}
            
        case 15: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if nav.topViewController is JobAbroadVC {
            return
        }
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobAbroadVC") as? JobAbroadVC {
            nav.pushViewController(vc, animated: true)
        }}
            
            
  default: if model.linkOpenType == "Web" {
                 commonWeb(model:model)
             }
        }}
    
    
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
            nav.pushViewController(vc, animated: true)
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
    
}
 /* LatestEventsVC
        case 3:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is UNStudentQRCodeVC {
                return
            }
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNStudentQRCodeVC") as? UNStudentQRCodeVC {
                nav.pushViewController(vc, animated: true)
            }}
        case 4:print("Notifications Tapped")
        case 5:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                if nav.topViewController is UNStudentAgentListVC {
                    return
                }
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNStudentAgentListVC") as? UNStudentAgentListVC {
                nav.pushViewController(vc, animated: true)
            }
            }
        case 6: if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNStudentSearchOptionVC") as? UNStudentSearchOptionVC {
            vc.delegate = self
            AppDelegate.shared.window?.rootViewController?.add(vc)
        }
           
        case 7:print("Search Events Tapped")
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                   if nav.topViewController is SearchEventVC {
                       return
                       }
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "SearchEventVC") as?  SearchEventVC {
                nav.pushViewController(vc, animated: true)
                }
            }
            
            
        case 8:print("Favourites Tapped")
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is UNFavouritesBaseVC {
                return
                }
                if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNFavouritesBaseVC") as? UNFavouritesBaseVC {
                        nav.pushViewController(vc, animated: true)
                           }
        }
            //UNFavouritesBaseVC
           
            
        case 9:print("Global Application Tapped")
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                     if nav.topViewController is UNFavouritesBaseVC {
                         return
                }
                
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GlobalProfileStepOneVC") as? GlobalProfileStepOneVC {
                            AppSession.share.globalProfile = GlobalProfileModel()
                            AppSession.share.courseList = [CourseModel]()
                        nav.pushViewController(vc, animated: true)
               }
        }
        case 10:print("My Applications Tapped")
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                        if nav.topViewController is StudentApplicationVC {
                            return
                   }
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "StudentApplicationVC") as? StudentApplicationVC {
                       nav.pushViewController(vc, animated: true)
              }
            }
        case 11:print("Refer A friends")
        case 12:commonWeb(type: .importantLink, title: "Important Links")
        case 13: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if nav.topViewController is UNStudentShortListCourseVC {
                return
            }
            
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNStudentShortListCourseVC") as? UNStudentShortListCourseVC {
                nav.pushViewController(vc, animated: true)
            }}
        case 14:commonWeb(type: .scholarShip, title: "Scholarship")
        case 15:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            if let vc = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "UNSettingsVC") as? UNSettingsVC {
            nav.pushViewController(vc, animated: true)
            }
        }
            
        default:break
        }
    }
    
    func commonWeb(type:webLinkType,title:String){
        
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
            vc.linkType = type
            vc.controllerTitle = title
            nav.push(viewController: vc)
           // AppDelegate.shared.window?.rootViewController?.add(vc)
            }}
        
    }
    }
*/

/*
extension UNStudentLeftMenuVC {
    func showLogOutAlertMsg(msg: String) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to logout form UNICA", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .default, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "YES", style: .default) { (alrt) in
            CoreDataManager.shared.clearDatabase()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.09, execute: {
                AppDelegate.shared.setRootViewController(vc: .Login)
            })
        }
        alert.addAction(yesAction)
        AppDelegate.shared.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

*/
