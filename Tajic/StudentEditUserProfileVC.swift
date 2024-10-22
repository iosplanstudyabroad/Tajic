//
//  StudentEditUserProfileVC.swift
//  Unica
//
//  Created by Mohit Kumar  on 26/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit

class StudentEditUserProfileVC: UIViewController {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var table: TPKeyboardAvoidingTableView!
    @IBOutlet var userImageBtn:UIButton!
    
    @IBOutlet var passwordView: UIStackView!
    
    @IBOutlet var confirmPasswordView: UIStackView!
    @objc var prefillDict:[String:Any]?
    var picker                     = UIImagePickerController()
    var selectedImage:UIImage?
    var referralCellHeight:CGFloat = 35
    var countryCellHeight:CGFloat  = 110
    var isRferralEnabled           = false
  //  var isEditingEnable            = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configure(){
        table.cornerRadius(10)
        prefillUserImage()
        picker.delegate = self
        picker.allowsEditing = true
       
        getUserProfile()
    }
    
    func getUserProfile(){
        
        let rModel = RegistrationViewModel()
        rModel.getStudentProfile { (dict) in
            print(dict)
            self.prefillDict = dict
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.prefillUserImage()
                self.countryTableUpdated()
                self.table.reloadData()
                
            }
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
    
   
    
    @IBAction func editBtnTapped(_ sender: UIBarButtonItem) {
        sender.title  = "Editing"
        userImageBtn.isUserInteractionEnabled = true
        self.table.reloadData()
    }
    @IBAction func saveExitBtnTapped(_ sender: Any) {
        if validation() {
           updateProfile(image: userImage.image, false)
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if validation() {
            updateProfile(image: userImage.image, true)
        }
    }
}

//***********************************************//
// MARK: Prefilll User Image
//***********************************************//
extension StudentEditUserProfileVC {
    func prefillUserImage(){
        
        /*

         if let country = data["asia-interested_country"] as? [[String:Any]],country.isEmpty == false  {
             country.forEach { (countryDict) in
                let model = CountryModel(with: countryDict)
                 AppSession.share.registerModel.countryList.append(model.name)
             }
         }
         */
        
        if let dict = prefillDict {
            AppSession.share.multiCountryList.removeAll()
            AppSession.share.registerModel.countryList.removeAll()
            self.table.reloadData()
            if let country = dict["interested_country_title"] as? [[String:Any]],country.isEmpty == false  {
                country.forEach { (countryDict) in
                   let model = CountryModel(with: countryDict)
                    if model.id.isEmpty == false && model.name.isEmpty == false {
            AppSession.share.registerModel.countryList.append(model.id)
            AppSession.share.multiCountryList.append(model)
                    }
                }
                self.table.reloadData()
            }
            
            
            if let imageUrl = dict["profile_image"] as? String {
            if let url = URL(string: imageUrl) {
                let placeHolder = UIImage(named: "RegisterUser")
                self.userImage.sd_setImage(with: url, placeholderImage: placeHolder, options: [], progress: nil, completed: nil)
                self.userImage.cornerRadius(self.userImage.frame.size.height/2)
                self.userImage.border(3, borderColor: .lightGray)
                
                
                }
            }
            
        }
    }
}
//***********************************************//
// MARK: Image Picker Defined Here
//***********************************************//
extension StudentEditUserProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
extension StudentEditUserProfileVC:TOCropViewControllerDelegate {
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
        self.picker.dismiss(animated: true, completion: nil)
        self.selectedImage = image
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
//***********************************************//
// MARK: Profile Validation
//***********************************************//
extension StudentEditUserProfileVC {
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
        
        return true
    }
}
//***********************************************//
// MARK: UITable View Methods
//***********************************************//
extension StudentEditUserProfileVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:return 840
        case 1:
               return countryCellHeight
        default: return referralCellHeight
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return configureTextCell(tableView, indexPath)
        case 1: return configureCountryCell(tableView, indexPath)
        default:return configureCountryCell(tableView, indexPath)
        }
    }
}

//***********************************************//
// MARK: UITableView Cell Defined Here
//***********************************************//
extension StudentEditUserProfileVC {
    func configureCountryCell(_ table:UITableView, _ index:IndexPath)-> RegistrationAddCountryCell {
        let cell = table.dequeueReusableCell(withIdentifier: "RegistrationAddCountryCell") as! RegistrationAddCountryCell
        cell.delegate = self
        cell.configure()
        cell.isUserInteractionEnabled = true
        return cell
    }
    
       func configureTextCell(_ table:UITableView,_ index:IndexPath)-> StudentRegistrationTextCell {
           let cell = table.dequeueReusableCell(withIdentifier:"RegistrationTextCell") as! StudentRegistrationTextCell
           cell.configure()
           cell.prefillData(prefillDict)
        cell.isUserInteractionEnabled = true
           return cell
       }
}
extension StudentEditUserProfileVC:countryUpdateProtocol{
    func countryTableUpdated() {
      countryCellHeight =  90
        let count = AppSession.share.multiCountryList.count
        if count % 2 == 0 {
            let height:CGFloat = CGFloat((count/2)*50)
            countryCellHeight += height
        }else{
            let heightO = Double(count)/2
            let roundValue = heightO.rounded(.up)
            let height:CGFloat = CGFloat(roundValue*50)
             countryCellHeight += height
        }
        isRferralEnabled.toggle()
        self.table.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
        
    }
}

extension StudentEditUserProfileVC {
    func updateProfile(image:UIImage?,_ isFromNext:Bool){
        let rModel = RegistrationViewModel()
        let dataModel = AppSession.share.registerModel
        if dataModel.deviceToken.isEmpty {
            if let dToken = UserDefaults.standard.object(forKey: "kDeviceid") as? String {
             dataModel.deviceToken = dToken
            }else{
                dataModel.deviceToken = "abcd232323jjhh"
            }
        }
        ActivityView.show()
        rModel.updateStudentProfile(image, dataModel) { (code,dict) in
            print(dict)
            if let status = dict["Code"] as? Int, status == 200 {
                self.selectedImage = nil
                ActivityView.hide()
                if isFromNext {
                    self.moveToMiniProfile()
                    return
                }
                self.updateUserModel()
                if let message = dict["Message"] as? String {
                    self.successMsg(message)
                }
            }else{
                ActivityView.hide()
                if let message = dict["Message"] as? String {
                    self.showAlertMsg(msg: message)
                }
            }
        }
       
    }
    
    func updateUserModel(){
        let rModel = RegistrationViewModel()
        rModel.getStudentProfile { (dict) in
            print(dict)
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
              let model = UserModel(With: dict)
                model.saved()
              
            }
        }
    }
}
extension StudentEditUserProfileVC {
    func successMsg(_ msg:String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle:.alert)
        let okBtn = UIAlertAction(title: "OK", style: .default) { (act) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
}
extension StudentEditUserProfileVC {
    
    func moveToMiniProfile(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepOneProfileVC") as? StepOneProfileVC {
            vc.isEditing = true
            //vc.incomingViewType = kMyProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

