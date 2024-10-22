//
//  StudentRgistrationVC.swift
//  Unica
//
//  Created by Mohit Kumar  on 21/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit
import SafariServices
class StudentRgistrationVC: UIViewController {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var table: TPKeyboardAvoidingTableView!
    @IBOutlet var card: UIView!
    
    @IBOutlet var acceptBtn: UIButton!
    
    @IBOutlet var termConditionLabl: UILabel!
    
    
    @objc var prefillDict:NSMutableDictionary?
    var picker                     = UIImagePickerController()
    var selectedImage:UIImage?
    var referralCellHeight:CGFloat = 35
    var countryCellHeight:CGFloat  = 110
    var isRferralEnabled           = false
    
    var fbuser:FaceBookUser?
    var gmailUser:GmailUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        
        acceptBtn.setImage(UIImage(named: "squareunchacked.png"), for: .normal)
        prefillUserImage()
        picker.delegate = self
        picker.allowsEditing = true
        card.cardView()
        if let nav = self.navigationController {
          nav.configureNavigation()
        }
        let title = NSMutableAttributedString(string:"I Accept Terms & Conditions")
        title.setColorForText(textForAttribute:"Terms" , withColor: .blue)
        title.setColorForText(textForAttribute:"Conditions" , withColor: .blue)
        self.termConditionLabl.attributedText = title
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(termTapped(tap:)))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        self.termConditionLabl.addGestureRecognizer(tap)
        self.termConditionLabl.isUserInteractionEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func termTapped(tap:UITapGestureRecognizer){
        let text = self.termConditionLabl.text!
        if let range = text.range(of: "Terms & Conditions")?.nsRange(in:text ) {
        if tap.didTapAttributedTextInLabel(label: self.termConditionLabl, inRange: range) {
               openTermsAndConditions()
        }
        }

        if let range = text.range(of: "I Accept")?.nsRange(in: text) {
            if tap.didTapAttributedTextInLabel(label: self.termConditionLabl, inRange: range) {
//                AppSession.share.registerModel.isTermAndConditionsAccepted = true
//                acceptBtn.setImage(UIImage(named: "squrechecked.png"), for: .normal)
        }
        }
    }
     
   

    func openTermsAndConditions(){
        let baseUrl = ServiceConst.BaseUrl + "student-term-and-conditions.php?app_agent_id=\(UserModel.getObject().agentId)"
        if let url = URL(string: baseUrl) {
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        }
        
    }

    
    //***********************************************//
    // MARK:UIButton Action Defined Here
    //***********************************************//
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func userImageBtnTapped(_ sender: Any) {
        showPickerAlert()
       }
    
    @IBAction func acceptBtnTapped(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "squareunchacked.png") {
            sender.setImage(UIImage(named: "squrechecked.png"), for: .normal)
            AppSession.share.registerModel.isTermAndConditionsAccepted  = true
        }else{
           sender.setImage(UIImage(named: "squareunchacked.png"), for: .normal)
            AppSession.share.registerModel.isTermAndConditionsAccepted  = false
        }
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        if validation(){
            uploadImage(image: self.selectedImage)
        }
       }
    
}
extension StudentRgistrationVC:UIGestureRecognizerDelegate{
    
}
//***********************************************//
// MARK: Prefilll User Image
//***********************************************//
extension StudentRgistrationVC {
    func prefillUserImage(){
        if let dict = prefillDict {
            if let imageUrl = dict["profile"] as? String {
            if let url = URL(string: imageUrl) {
                self.userImage.sd_setImage(with: url, placeholderImage: nil, options: [], progress: nil, completed: nil)
                self.userImage.cornerRadius(self.userImage.frame.size.height/2)
                }
            }
        }
    }
}
//***********************************************//
// MARK: Image Picker Defined Here
//***********************************************//
extension StudentRgistrationVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func showPickerAlert(){
        let alertVC = UIAlertController(title: "Choose an option", message: "", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
            }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.picker.sourceType = .photoLibrary
          self.present(self.picker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(galleryAction)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  else { return  }
        self.cropeImage(image)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension StudentRgistrationVC:TOCropViewControllerDelegate {
    func cropeImage(_ image:UIImage){
        picker.dismiss(animated: true, completion: nil)
        let croper = TOCropViewController(croppingStyle: .default, image: image)
        croper.delegate = self
        self.present(croper, animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
       cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        print(image)
        self.userImage.image = image
        self.userImage.cornerRadius(self.userImage.frame.size.height/2)
        self.userImage.border(1, borderColor:UIColor().themeColor())
        self.picker.dismiss(animated: true, completion: nil)
        self.selectedImage = image
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
}
//***********************************************//
// MARK: Profile Validation
//***********************************************//
extension StudentRgistrationVC {
    func validation()-> Bool {
        let model = AppSession.share.registerModel

        if model.firstName.isEmpty {
            showAlertMsg(msg: "Enter your First Name")
            return false
        }
        if model.lastName.isEmpty {
            showAlertMsg(msg: "Enter your Last Name")
            return false
        }
        if model.email.isEmpty {
            showAlertMsg(msg: "Enter Email")
            return false
        }
        if model.email.isValidEmail == false {
            showAlertMsg(msg: "Email is not in valid format")
            return false
        }
        if model.countryId.isEmpty {
                   showAlertMsg(msg: "Select country")
                   return false
               }
        if model.mobile.isEmpty {
            showAlertMsg(msg: "Enter your Mobile Number")
            return false
        }
        if model.dob.isEmpty {
            showAlertMsg(msg: "Select Your Date of Birth")
            return false
        }
        if model.city.isEmpty{
            showAlertMsg(msg: "Enter your City")
            return false
        }
        if model.levelOfStudy.isEmpty {
            showAlertMsg(msg: "Select level of study you wish to apply")
            return false
        }
        if model.year.isEmpty {
            showAlertMsg(msg: "Select Year")
            return false
            }
        if model.courseTypeId.isEmpty {
        showAlertMsg(msg: "Select Course Type")
        return false
        }
        if model.fieldOfStudy.isEmpty {
            showAlertMsg(msg: "Enter the field of study that you are intersted in")
            return false
        }
        if model.budget.isEmpty {
           showAlertMsg(msg: "Select Budget")
           return false
           }
        if model.countryList.isEmpty {
            showAlertMsg(msg: "Please select country of interest")
            return false
        }
        if isRferralEnabled {
            if model.referalCode.isEmpty {
                showAlertMsg(msg: "Please Enter Referral Code")
                return false
            }
        }
        
        if model.isTermAndConditionsAccepted == false {
            showAlertMsg(msg: "Please accept Terms & Conditions")
            return false
        }
        return true
    }
}
//***********************************************//
// MARK: UITable View Methods
//***********************************************//
extension StudentRgistrationVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return 840 //960
        case 1:return countryCellHeight
        default:return countryCellHeight //return referralCellHeight
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return configureTextCell(tableView, indexPath)
        case 1: return configureCountryCell(tableView, indexPath)
        default:return configureCountryCell(tableView, indexPath) //configureReferralCell(tableView, indexPath)
        }
    }
}
//

//***********************************************//
// MARK: UITableView Cell Defined Here
//***********************************************//
extension StudentRgistrationVC {
    func configureCountryCell(_ table:UITableView, _ index:IndexPath)-> RegistrationAddCountryCell {
        let cell = table.dequeueReusableCell(withIdentifier: "RegistrationAddCountryCell") as! RegistrationAddCountryCell
        cell.delegate = self
        cell.configure()
        return cell
    }

       func configureTextCell(_ table:UITableView,_ index:IndexPath)-> StudentRegistrationTextCell {
           let cell = table.dequeueReusableCell(withIdentifier:"RegistrationTextCell") as! StudentRegistrationTextCell
           cell.configure()
           cell.prefillModel(gmailUser,fbuser)
           return cell
       }
}

extension StudentRgistrationVC:countryUpdateProtocol{
    func countryTableUpdated() {
      countryCellHeight =  110
        let count = AppSession.share.multiCountryList.count
        if count % 2 == 0 {
            let height:CGFloat = CGFloat((count/2)*70)
            countryCellHeight += height
        }else{
            let heightO = Double(count)/2
            let roundValue = heightO.rounded(.up)
            let height:CGFloat = CGFloat(roundValue*70)
             countryCellHeight += height
        }
        self.table.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
    
}

extension StudentRgistrationVC {
    func uploadImage(image:UIImage?){
        let rModel = RegistrationViewModel()
        let dataModel = AppSession.share.registerModel
        if dataModel.deviceToken.isEmpty {
            if let dToken = UserDefaults.standard.object(forKey: "device") as? String {
             dataModel.deviceToken = dToken
            }else{
                dataModel.deviceToken = "abcd232323jjhh"
            }
        }
        rModel.registerStudent(image, dataModel) { (code,dict) in
            print(dict)
            if let status = dict["Code"] as? Int, status == 200 {
                if let paylaod = dict["Payload"] as? [String:Any] {
                    let model = UserModel(With: paylaod)
                    model.profileCompleted = "Y"
                       model.saved()
                    AppDelegate.shared.setRootViewController(vc: .Home)
                }
            }else{
                if let message = dict["Message"] as? String {
                    self.showAlertMsg(msg: message)
                }
            }
        }
    }
}
