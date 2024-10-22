//
//  UTLoginVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 07/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.

import UIKit
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit

@available(iOS 13.0, *)
class UTLoginVC: UIViewController {
    //@IBOutlet var card: UIView!
    //@IBOutlet var appleSupportView: UIView!
    //@IBOutlet var googleBtn:UIButton!
    //@IBOutlet var fbBtn:UIButton!
    
    @IBOutlet var fbBackView: UIView!
    @IBOutlet var gmailBackView: UIView!
    @IBOutlet var appleBackView: UIView!
    
    
    
    
    var gmailModel:GmailUser? = nil
    let appleLoginBtn = ASAuthorizationAppleIDButton(type: .default, style: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
         //appleLoginBtn.frame = appleSupportView.frame
    }
    func appleConfigure(){
        appleLoginBtn.cornerRadius(10)
        //googleBtn.border(1, borderColor: .white)
        //fbBtn.border(1, borderColor: .white)
        //appleLoginBtn.border(1, borderColor: .white)
       //performExistingAccountSetupFlows()
        //appleLoginBtn.addTarget(self, action: #selector(appleLoginBtnTapped), for: .touchUpInside)
        //appleLoginBtn.frame = appleSupportView.frame
       //appleSupportView.addSubview(appleLoginBtn)
    }
    func configure(){
        fbBackView.cardViewWithCircle()
        gmailBackView.cardViewWithCircle()
        appleBackView.cardViewWithCircle()
        appleConfigure()
    }
    
    func appleAuth(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        if let currentUserIdentifier = KeychainItem.currentUserIdentifier {
appleIDProvider.getCredentialState(forUserID:currentUserIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:print("authorized")
                case .revoked:print("revoked")
                case .notFound:print("notFound")
                default:break
                }
            }
        }
    }
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func appleLoginBtnTapped(_ sender:ASAuthorizationAppleIDButton){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func googleLoginBtnTapped(_ sender:UIButton){
        loginWithGoogle()
    }
    @IBAction func faceBookLoginBtnTapped(_ sender:UIButton){
      loginWithFB()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        UserDefaults.standard.removeObject(forKey: "menu")
    }
}
@available(iOS 13.0, *)
extension UTLoginVC{
    func performExistingAccountSetupFlows() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}
@available(iOS 13.0, *)
extension UTLoginVC: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            KeychainItem.currentUserIdentifier = appleIDCredential.user
            KeychainItem.currentUserFirstName = appleIDCredential.fullName?.givenName
            KeychainItem.currentUserLastName = appleIDCredential.fullName?.familyName
            KeychainItem.currentUserEmail = appleIDCredential.email
            print("User Id - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.familyName ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")
            var idToken = ""
            if let identityTokenData = appleIDCredential.identityToken,
                let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                idToken = identityTokenString
                print("Identity Token \(identityTokenString)")
            }
            let fullName = (appleIDCredential.fullName?.givenName ??  "") + (appleIDCredential.fullName?.familyName ?? "")
            let givenName = appleIDCredential.fullName?.givenName ??  ""
            let familyName = appleIDCredential.fullName?.familyName ??  ""
            let email = appleIDCredential.email ?? ""
            let model = GmailUser(userId: appleIDCredential.user, idToken: idToken, fullName: fullName, givenName: givenName, familyName: familyName, email: email, profileImageUrl: nil)
            AppSession.share.registrationType = (id:1,type:"Gmail")
            getStudentAppleLoginStatus(model)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let username = passwordCredential.user
            let password = passwordCredential.password
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",message: message,preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    }
@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension UTLoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
//***********************************************//
// MARK: Google Login  & Delegates
//***********************************************//
@available(iOS 13.0, *)
extension UTLoginVC
{
    
    func loginWithGoogle(){
        let signInConfig = GIDConfiguration.init(clientID: GoogleConst.ClientId)

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { usr, error in
        guard error == nil else { return }

            guard let user = usr else { return }
        
            if let userId      = user.userID,let idToken    = user.authentication.idToken,let fullName   = user.profile?.name,let givenName  = user.profile?.givenName,let familyName = user.profile?.familyName,let email      = user.profile?.email {
                self.gmailModel = GmailUser(userId: userId, idToken: idToken, fullName: fullName, givenName: givenName, familyName: familyName, email: email, profileImageUrl: nil)
                AppSession.share.registrationType = (id:1,type:"Gmail")
                
                self.getStudentSocialLoginStatus(fbModel: nil, gmailUser: self.gmailModel)
            } else {
                print("error")
            }
        
      }

    }
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    private func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,  withError error: Error!) {
        print("The User left the app")
    }
}
//***********************************************//
// MARK: Facebook Login
//***********************************************//
@available(iOS 13.0, *)
extension UTLoginVC {
    func loginWithFB(){
        LoginManager().logIn(permissions: ["email"], from: self) { (result, error) in
            if error == nil , let loginResult = result {
                guard loginResult.isCancelled == false else {
                    return
                }
                if  loginResult.grantedPermissions.contains("email") {
                    guard AccessToken.current != nil else {
                        return
                    }
                    GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                        if let finalData = result as? [String:Any] {
                            print(finalData)
                            if let userid = finalData["id"] as? String, let fullName = finalData["name"] as? String,let firstName = finalData["first_name"] as? String,let lastName = finalData["last_name"] as? String,let email = finalData["email"] as? String,let pictureDict = finalData["picture"]as? [String:Any], let imageDict = pictureDict["data"] as? [String:Any] , let imageUrl = imageDict["url"] as? String {
                                let url = URL(string:imageUrl)
                              let user = FaceBookUser(userId: userid, fullName: fullName, firstName: firstName, lastName: lastName, email: email, profileImageUrl: url)
                                AppSession.share.registrationType = (id:2,type:"Facebook")
                                self.getStudentSocialLoginStatus(fbModel: user, gmailUser: nil)
                            }
                        }
                    })
                }
            }
        }
    }
}
//***********************************************//
// MARK: Student Login Webservice
//***********************************************//
@available(iOS 13.0, *)
extension UTLoginVC{
    func getStudentSocialLoginStatus(fbModel:FaceBookUser?,gmailUser:GmailUser?) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        var params = [String:Any]()
        let instance = AppSession.share
        switch AppSession.share.registrationType {
        case (id:1,type:"Gmail"):
            params = ["app_agent_id":instance.agentId,"email":gmailUser!.email,"socialid":gmailUser!.userId,"firstname":gmailUser!.givenName,"lastname":gmailUser!.familyName,"deviceToken" :PushNotificationHandler.deviceToken,"deviceType":"I"]
         case (id:2,type:"Facebook"):
            params = ["app_agent_id":instance.agentId,"email":fbModel!.email,"socialid":fbModel!.userId,"firstname":fbModel!.firstName]
        default:break
        }
        ActivityView.show()
        WebServiceManager.instance.studentSocialLoginStatusWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any],let registrationStatus = data["registration_status"] as? String, let userId = data["id"] as? String {
                    if registrationStatus.toBool() == true{
                       let model = UserModel(With: data)
                        model.profileCompleted = "Y"
                           model.saved()
                         UserDefaults.standard.set("Stu", forKey: UDConst.userLoginType)
                        AppDelegate.shared.setRootViewController(vc: .Home)
                    }
                    else{
                        ActivityView.hide()
                        AppSession.share.tempUserId =  userId
                        if  let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentRgistrationVC") as? StudentRgistrationVC {
                            switch AppSession.share.registrationType {
                            case (id:1,type:"Gmail"):vc.gmailUser = gmailUser
                            case (id:2,type:"Facebook"):vc.fbuser = fbModel
                            default:break
                            }
                            if let nav = self.navigationController {
                            self.navigationController?.navigationBar.isHidden = false
                                nav.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:break
            }
        }
    }
}

@available(iOS 13.0, *)
extension UTLoginVC {
    func getStudentAppleLoginStatus(_ user:GmailUser?) {
           guard StaticHelper.isInternetConnected else {
               showAlertMsg(msg: AlertMsg.InternectDisconnectError)
               return
           }
        let instance = AppSession.share
        let  params = ["app_agent_id":instance.agentId,"email":user!.email,"apple_user_id":user!.userId,"firstname":user!.givenName,"lastname":user!.familyName,"deviceToken" :PushNotificationHandler.deviceToken,"deviceType":"I"]
           ActivityView.show()
           WebServiceManager.instance.studentSocialLoginStatusWithDetails(params: params) { (status, json) in
               switch status {
               case StatusCode.Success:
                   if let data = json["Payload"] as? [String:Any],let registrationStatus = data["registration_status"] as? String, let userId = data["id"] as? String {
                       
                       if registrationStatus.toBool() == true{
                          let model = UserModel(With: data)
                           model.profileCompleted = "Y"
                              model.saved()
                            UserDefaults.standard.set("Stu", forKey: UDConst.userLoginType)
                           AppDelegate.shared.setRootViewController(vc: .Home)
                       }
                       else{
                           ActivityView.hide()
                           AppSession.share.tempUserId =  userId
                           if  let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentRgistrationVC") as? StudentRgistrationVC {
                               vc.gmailUser = user
                               if let nav = self.navigationController {
                                    self.navigationController?.navigationBar.isHidden = false
                                   nav.pushViewController(vc, animated: true)
                               }
                           }
                       }
                   }
                   else{
                       self.showAlertMsg(msg: json["Message"] as! String)
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
