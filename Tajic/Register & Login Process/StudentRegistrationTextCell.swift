//
//  StudentRegistrationTextCell.swift
//  Unica
//
//  Created by Mohit Kumar  on 21/02/20.
//  Copyright © 2020 Unica Sloutions Pvt Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class StudentRegistrationTextCell: UITableViewCell{
    @IBOutlet var eventNameBtn: UIButton!
    @IBOutlet var firstName: SkyFloatingLabelTextField!
    @IBOutlet var lastName: SkyFloatingLabelTextField!
    @IBOutlet var email: SkyFloatingLabelTextField!
    @IBOutlet var countryNameBtn: UIButton!
    @IBOutlet var mobile: SkyFloatingLabelTextField!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var dateofBirthBtn: UIButton!
    @IBOutlet var city: SkyFloatingLabelTextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var levelOfStudyBtn: UIButton!
    @IBOutlet var fieldOfStudyBtn: UIButton!
    @IBOutlet var fieldOfStudySecondOptionBtn:UIButton!
    @IBOutlet var yearBtn: UIButton!
    @IBOutlet var budgetBtn: UIButton!
    @IBOutlet var courseTypeBtn:UIButton!
    @IBOutlet var passwordView: UIStackView!
    @IBOutlet var eventView: UIStackView!
    @IBOutlet var confirmPasswordView: UIStackView!
    @IBOutlet var textFieldArray: [SkyFloatingLabelTextField]!
    
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var yearArray = [String]()
    var fieldOfStudy = ""
    var courseTypeArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(){
        eventNameBtn.titleLabel?.lineBreakMode    = .byWordWrapping
        eventNameBtn.titleLabel?.textAlignment    = .left
        countryNameBtn.titleLabel?.lineBreakMode  = .byWordWrapping
        countryNameBtn.titleLabel?.textAlignment  = .left
        levelOfStudyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        levelOfStudyBtn.titleLabel?.textAlignment = .left
        fieldOfStudyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        fieldOfStudyBtn.titleLabel?.textAlignment = .left
        fieldOfStudySecondOptionBtn.titleLabel?.lineBreakMode = .byWordWrapping
        fieldOfStudySecondOptionBtn.titleLabel?.textAlignment = .left
        textFieldSetup()
        
    }
    //364365
    func textFieldSetup(){
        if textFieldArray != nil  {
            textFieldArray.forEach { (textField) in
                textField.tintColor            = UIColor().hexStringToUIColor(hex: "#73AE57")
                textField.textColor          = .black
               // textField.lineColor          = UIColor().hexStringToUIColor(hex: "#64BFCB")
            textField.selectedTitleColor = UIColor().hexStringToUIColor(hex: "#364365")
                textField.titleColor     = UIColor().hexStringToUIColor(hex: "#364365")
            textField.selectedLineColor  = UIColor().hexStringToUIColor(hex: "#364365")
              //  textField.placeholderColor   = UIColor().hexStringToUIColor(hex: "#64BFCB")
                textField.titleFormatter       = { $0.capitalizingFirstLetter()}

                textField.delegate = self
            }
        }
    }

    @IBAction func eventNameBtnTapped(_ sender: Any) {
        self.endEditing(true)
    }
    
    @IBAction func countryNameBtnTapped(_ sender: Any) {
        self.endEditing(true)
     if let vc = storyBoard.instantiateViewController(withIdentifier: "CountryListVC") as? CountryListVC {
                vc.delegate = self
                if let window = UIApplication.shared.keyWindow {
                    window.rootViewController?.add(vc)
                }
            }
    }
    
    @IBAction func genderBtnTapped(_ sender: Any) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
            vc.isEditing = true
            vc.viewType = "Gender"
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func dateofBirthBtnTapped(_ sender: Any) {
        self.endEditing(true)
        datePicker()
    }
    /*
     if let vc = storyBoard.instantiateViewController(withIdentifier: "DateVC") as? DateVC {
         vc.delegate = self
         if let window = UIApplication.shared.keyWindow {
             window.rootViewController?.add(vc)
         }
     }
    }
*/
    
    func datePicker(){
        let pickerView = Bundle.main.loadNibNamed("DateSelectorView", owner: self, options: nil)![0] as?
        DateSelectorView
        pickerView?.frame = UIScreen.main.bounds
        pickerView?.delegate = self
         //pickerView?.selectedDate = date
        pickerView?.isDobValidation = true
         pickerView?.setupPickers()
        //AppDelegate.shared.window!.rootViewController?.view.addSubview(pickerView!)
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController?.view.addSubview(pickerView!)
        }
    }
    
    @IBAction func levelOfStudyBtnTapped(_ sender: Any) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "DegreePopUpVC") as? DegreePopUpVC {
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func fieldOfStudyBtnTapped(_ sender: Any) {
        self.endEditing(true)
        self.fieldOfStudy = "option 1"
        fieldOfStudyDialouge()
    }
    
    @IBAction func fieldOfStudySecondOptionBtnTapped(_ sender: Any) {
           self.endEditing(true)
          self.fieldOfStudy = "option 2"
        fieldOfStudyDialouge(true)
       }
    
    func fieldOfStudyDialouge(_ isOptionTwo:Bool = false){
        if let vc = storyBoard.instantiateViewController(withIdentifier:"searchSubCategoryVC" ) as? searchSubCategoryVC {
            vc.delegate = self
            vc.isEditing = isOptionTwo
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func yearBtnTapped(_ sender: UIButton) {
         if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
           vc.delegate = self
           if let window = UIApplication.shared.keyWindow {
               window.rootViewController?.add(vc)
           }
       }
    }
    @IBAction func nextBtnTapped(_ sender: UITextField) {
        moveToNext(sender.tag)
    }
  
    @IBAction func budgetBtnTapped(_ sender: UIButton) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
            vc.isEditing = true
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    @IBAction func courseTypeBtnTapped(_ sender:UIButton){
        self.endEditing(true)
   if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
                   vc.isEditing = true
                   vc.viewType = "Course Type"
                   vc.delegate = self
                   if let window = UIApplication.shared.keyWindow {
                       window.rootViewController?.add(vc)
                   }
               }
    }
}
extension StudentRegistrationTextCell:dateProtocol{
    func selectedDate(date: Date) {
        let dateTitle  = ISO8601DateFormatter().convertDate(date)
        self.dateofBirthBtn.setTitle(dateTitle, for: .normal)
        AppSession.share.registerModel.dob = dateTitle
    }
}
extension StudentRegistrationTextCell:SubCategoryDelegate{
    func getSelectCategory(model: CountryModel) {
        fieldOfStudyBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.fieldOfStudy = model.id
    }
    func getSelectCategorySecondOption(model: CountryModel) {
        fieldOfStudySecondOptionBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.fieldOfStudySecondOption = model.id
    }
}
extension StudentRegistrationTextCell {
    func prefillModel(_ gmUser:GmailUser?,_ fbUser:FaceBookUser?){
         self.textFieldSetup()
        if let user                                  = fbUser {
            self.firstName.text                      = user.firstName
            AppSession.share.registerModel.firstName = user.firstName
            self.lastName.text                       = user.lastName
            AppSession.share.registerModel.lastName  = user.lastName
            self.email.text                          = user.email
           AppSession.share.registerModel.email      = user.email
        }
        if let user = gmUser {
            self.firstName.text                      = user.givenName
            AppSession.share.registerModel.firstName = user.givenName
            self.lastName.text                       = user.familyName
            AppSession.share.registerModel.lastName  = user.familyName
            self.email.text                          = user.email
            AppSession.share.registerModel.email     = user.email
        }
        
       
    }
}

extension StudentRegistrationTextCell {
    func moveToNext(_ index:Int){
        switch index {
        case 10:firstName.resignFirstResponder()
                lastName.becomeFirstResponder()
        case 20:lastName.resignFirstResponder()
                email.becomeFirstResponder()
        case 30:mobile.becomeFirstResponder()
        case 40:city.becomeFirstResponder()
        case 50:password.becomeFirstResponder()
        case 60:confirmPassword.becomeFirstResponder()
        case 70:self.endEditing(true)
        case 80:break
        case 90:break
        default:break
        }
    }
}
extension StudentRegistrationTextCell:eventDelegate {
    func getSelectedGender(model: eventModel) {
        self.genderBtn.setTitle(model.eventName, for: .normal)
        AppSession.share.registerModel.gender = model.name
    }
    func getSelectedYear(model: eventModel) {
        self.yearBtn.setTitle(model.id, for: .normal)
        AppSession.share.registerModel.year = model.id
    }
    func getSelectedBudget(model: eventModel) {
        budgetBtn.setTitle(model.budgetTitle, for: .normal)
        AppSession.share.registerModel.budget = model.id
    }
    func getCourseType(model: eventModel) {
        courseTypeBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.courseTypeId = model.id
    }
    func getSelectedDegree(model: DegreeModel) {
        self.levelOfStudyBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.levelOfStudy = model.id
    }
}
extension StudentRegistrationTextCell:countryDelegate{
    func getCountryForStudy(model: CountryModel) {
    }
    
    func getSelectedCountry(model: CountryModel) {
        print(model.name)
        self.countryNameBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.countryId = model.id
    }
}

extension StudentRegistrationTextCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result                             = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        updateModelAsPerTextField(text: result, tag: textField.tag)
      return true
    }
    func updateModelAsPerTextField(text:String,tag:Int){
        guard text.isEmpty == false else {
            return
        }
        print(text,tag)
        switch tag {
        case 10:AppSession.share.registerModel.firstName       = text
        case 20:AppSession.share.registerModel.lastName        = text
        case 30:AppSession.share.registerModel.email           = text
        case 40:AppSession.share.registerModel.mobile          = text
        case 50:AppSession.share.registerModel.city            = text
        case 60:AppSession.share.registerModel.password        = text
        case 70:AppSession.share.registerModel.confirmPassword = text
        default:break
        }
    }
}
extension StudentRegistrationTextCell{
    func prefillData(_ dict:[String:Any]?){
        if let data = dict {
        if let budget = data["budget_title"] as? String, let budgetId = data["budget_id"] as? String {
            self.budgetBtn.setTitle(budget, for: .normal)
            AppSession.share.registerModel.budget = budgetId
        }
        if let country = data["country_name"] as? String, let countryId = data["country_id"] as? String {
                   self.countryNameBtn.setTitle(country, for: .normal)
                   AppSession.share.registerModel.countryId = countryId
               }
        if let dob = data["date_of_birth"] as? String {
            dateofBirthBtn.setTitle(dob, for: .normal)
            AppSession.share.registerModel.dob = dob
        }
        if let email = data["email"] as? String {
            self.email.text = email
            AppSession.share.registerModel.email = email
        }
        if let firstName =  data["firstname"] as? String {
            self.firstName.text = firstName
            AppSession.share.registerModel.firstName = firstName
        }
        if let lastName = data["lastname"] as? String {
            self.lastName.text = lastName
            AppSession.share.registerModel.lastName = lastName
        }
        if let gender = data["gender"] as? String {
            self.genderBtn.setTitle(gender, for: .normal)
            AppSession.share.registerModel.gender = gender
        }
        if let city = data["residential_city"] as? String {
            self.city.text = city
            AppSession.share.registerModel.city = city
        }
          
        if let year = data["interested_year"] as? String {
            self.yearBtn.setTitle(year, for: .normal)
            AppSession.share.registerModel.year = year
        }
        
        if let number = data["mobileNumber"] as? String {
            self.mobile.text = number
            AppSession.share.registerModel.mobile = number
        }
            if let levelOfStudyId = data["apply_education_level_id"] as? String,let title =  data["apply_education_level_title"] as? String{
                self.levelOfStudyBtn.setTitle(title, for: .normal)
                AppSession.share.registerModel.levelOfStudy = levelOfStudyId
            }
            if let courseTypeId = data["apply_course_type_id"] as? String,let courseTypeTitle = data["apply_course_type_title"] as? String {
                self.courseTypeBtn.setTitle(courseTypeTitle, for: .normal)
                AppSession.share.registerModel.courseTypeId = courseTypeId
            }
            if let interestedId = data["interested_category_id"] as? [String], let interestedName = data["interested_category_title"] as? [String] {
                if let id = interestedId.first {
                    AppSession.share.registerModel.fieldOfStudy = id
                }
                if let name = interestedName.first {
                   self.fieldOfStudyBtn.setTitle(name, for: .normal)
                }
            }
            if let interestedId = data["interested_category_id_option2"] as? [String], let interestedName = data["interested_category_option2_title"] as? [String] {
                if let id = interestedId.first {
                    AppSession.share.registerModel.fieldOfStudySecondOption = id
                }
                if let name = interestedName.first {
                   self.fieldOfStudySecondOptionBtn.setTitle(name, for: .normal)
                }
            }
    }
    }
}


/*{
    @IBOutlet var eventNameBtn: UIButton!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var countryNameBtn: UIButton!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var dateofBirthBtn: UIButton!
    @IBOutlet var city: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var levelOfStudyBtn: UIButton!
    @IBOutlet var fieldOfStudyBtn: UIButton!
    @IBOutlet var fieldOfStudySecondOptionBtn:UIButton!
    @IBOutlet var yearBtn: UIButton!
    @IBOutlet var budgetBtn: UIButton!
    @IBOutlet var courseTypeBtn:UIButton!
    @IBOutlet var passwordView: UIStackView!
    @IBOutlet var eventView: UIStackView!
    @IBOutlet var confirmPasswordView: UIStackView!
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var yearArray = [String]()
    var fieldOfStudy = ""
    var courseTypeArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(){
        eventNameBtn.titleLabel?.lineBreakMode    = .byWordWrapping
        eventNameBtn.titleLabel?.textAlignment    = .left
        countryNameBtn.titleLabel?.lineBreakMode  = .byWordWrapping
        countryNameBtn.titleLabel?.textAlignment  = .left
        levelOfStudyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        levelOfStudyBtn.titleLabel?.textAlignment = .left
        fieldOfStudyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        fieldOfStudyBtn.titleLabel?.textAlignment = .left
        fieldOfStudySecondOptionBtn.titleLabel?.lineBreakMode = .byWordWrapping
        fieldOfStudySecondOptionBtn.titleLabel?.textAlignment = .left
    }

    @IBAction func eventNameBtnTapped(_ sender: Any) {
        self.endEditing(true)
    }
    
    @IBAction func countryNameBtnTapped(_ sender: Any) {
        self.endEditing(true)
     if let vc = storyBoard.instantiateViewController(withIdentifier: "CountryListVC") as? CountryListVC {
                vc.delegate = self
                if let window = UIApplication.shared.keyWindow {
                    window.rootViewController?.add(vc)
                }
            }
    }
    
    @IBAction func genderBtnTapped(_ sender: Any) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
            vc.isEditing = true
            vc.viewType = "Gender"
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func dateofBirthBtnTapped(_ sender: Any) {
        self.endEditing(true)
        datePicker()
    }
    /*
     if let vc = storyBoard.instantiateViewController(withIdentifier: "DateVC") as? DateVC {
         vc.delegate = self
         if let window = UIApplication.shared.keyWindow {
             window.rootViewController?.add(vc)
         }
     }
    }
*/
    
    func datePicker(){
        let pickerView = Bundle.main.loadNibNamed("DateSelectorView", owner: self, options: nil)![0] as?
        DateSelectorView
        pickerView?.frame = UIScreen.main.bounds
        pickerView?.delegate = self
         //pickerView?.selectedDate = date
        pickerView?.isDobValidation = true
         pickerView?.setupPickers()
        //AppDelegate.shared.window!.rootViewController?.view.addSubview(pickerView!)
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController?.view.addSubview(pickerView!)
        }
    }
    
    @IBAction func levelOfStudyBtnTapped(_ sender: Any) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "DegreePopUpVC") as? DegreePopUpVC {
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func fieldOfStudyBtnTapped(_ sender: Any) {
        self.endEditing(true)
        self.fieldOfStudy = "option 1"
        fieldOfStudyDialouge()
    }
    
    @IBAction func fieldOfStudySecondOptionBtnTapped(_ sender: Any) {
           self.endEditing(true)
          self.fieldOfStudy = "option 2"
        fieldOfStudyDialouge(true)
       }
    
    func fieldOfStudyDialouge(_ isOptionTwo:Bool = false){
        if let vc = storyBoard.instantiateViewController(withIdentifier:"searchSubCategoryVC" ) as? searchSubCategoryVC {
            vc.delegate = self
            vc.isEditing = isOptionTwo
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
    @IBAction func yearBtnTapped(_ sender: UIButton) {
         if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
           vc.delegate = self
           if let window = UIApplication.shared.keyWindow {
               window.rootViewController?.add(vc)
           }
       }
    }
    @IBAction func nextBtnTapped(_ sender: UITextField) {
        moveToNext(sender.tag)
    }
  
    @IBAction func budgetBtnTapped(_ sender: UIButton) {
        self.endEditing(true)
        if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
            vc.isEditing = true
            vc.delegate = self
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    @IBAction func courseTypeBtnTapped(_ sender:UIButton){
        self.endEditing(true)
               if let vc = storyBoard.instantiateViewController(withIdentifier:"EventPopUPVC" ) as? EventPopUPVC {
                   vc.isEditing = true
                   vc.viewType = "Course Type"
                   vc.delegate = self
                   if let window = UIApplication.shared.keyWindow {
                       window.rootViewController?.add(vc)
                   }
               }
    }
}
extension StudentRegistrationTextCell:dateProtocol{
    func selectedDate(date: Date) {
        let dateTitle  = ISO8601DateFormatter().convertDate(date)
        self.dateofBirthBtn.setTitle(dateTitle, for: .normal)
        AppSession.share.registerModel.dob = dateTitle
    }
}
extension StudentRegistrationTextCell:SubCategoryDelegate{
    func getSelectCategory(model: CountryModel) {
        fieldOfStudyBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.fieldOfStudy = model.id
    }
    func getSelectCategorySecondOption(model: CountryModel) {
        fieldOfStudySecondOptionBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.fieldOfStudySecondOption = model.id
    }
}
extension StudentRegistrationTextCell {
    func prefillModel(_ gmUser:GmailUser?,_ fbUser:FaceBookUser?){
        if let user                                  = fbUser {
            self.firstName.text                      = user.firstName
            AppSession.share.registerModel.firstName = user.firstName
            self.lastName.text                       = user.lastName
            AppSession.share.registerModel.lastName  = user.lastName
            self.email.text                          = user.email
           AppSession.share.registerModel.email      = user.email
        }
        if let user = gmUser {
            self.firstName.text                      = user.givenName
            AppSession.share.registerModel.firstName = user.givenName
            self.lastName.text                       = user.familyName
            AppSession.share.registerModel.lastName  = user.familyName
            self.email.text                          = user.email
            AppSession.share.registerModel.email     = user.email
        }
    }
}

extension StudentRegistrationTextCell {
    func moveToNext(_ index:Int){
        switch index {
        case 10:firstName.resignFirstResponder()
                lastName.becomeFirstResponder()
        case 20:lastName.resignFirstResponder()
                email.becomeFirstResponder()
        case 30:mobile.becomeFirstResponder()
        case 40:city.becomeFirstResponder()
        case 50:password.becomeFirstResponder()
        case 60:confirmPassword.becomeFirstResponder()
        case 70:self.endEditing(true)
        case 80:break
        case 90:break
        default:break
        }
    }
}
extension StudentRegistrationTextCell:eventDelegate {
    func getSelectedGender(model: eventModel) {
        self.genderBtn.setTitle(model.eventName, for: .normal)
        AppSession.share.registerModel.gender = model.name
    }
    func getSelectedYear(model: eventModel) {
        self.yearBtn.setTitle(model.id, for: .normal)
        AppSession.share.registerModel.year = model.id
    }
    func getSelectedBudget(model: eventModel) {
        budgetBtn.setTitle(model.budgetTitle, for: .normal)
        AppSession.share.registerModel.budget = model.id
    }
    func getCourseType(model: eventModel) {
        courseTypeBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.courseTypeId = model.id
    }
    func getSelectedDegree(model: DegreeModel) {
        self.levelOfStudyBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.levelOfStudy = model.id
    }
}
extension StudentRegistrationTextCell:countryDelegate{
    func getCountryForStudy(model: CountryModel) {
    }
    
    func getSelectedCountry(model: CountryModel) {
        print(model.name)
        self.countryNameBtn.setTitle(model.name, for: .normal)
        AppSession.share.registerModel.countryId = model.id
    }
}

extension StudentRegistrationTextCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result                             = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        updateModelAsPerTextField(text: result, tag: textField.tag)
      return true
    }
    func updateModelAsPerTextField(text:String,tag:Int){
        guard text.isEmpty == false else {
            return
        }
        print(text,tag)
        switch tag {
        case 10:AppSession.share.registerModel.firstName       = text
        case 20:AppSession.share.registerModel.lastName        = text
        case 30:AppSession.share.registerModel.email           = text
        case 40:AppSession.share.registerModel.mobile          = text
        case 50:AppSession.share.registerModel.city            = text
        case 60:AppSession.share.registerModel.password        = text
        case 70:AppSession.share.registerModel.confirmPassword = text
        default:break
        }
    }
}
extension StudentRegistrationTextCell{
    func prefillData(_ dict:[String:Any]?){
        if let data = dict {
        if let budget = data["budget_title"] as? String, let budgetId = data["budget_id"] as? String {
            self.budgetBtn.setTitle(budget, for: .normal)
            AppSession.share.registerModel.budget = budgetId
        }
        if let country = data["country_name"] as? String, let countryId = data["country_id"] as? String {
                   self.countryNameBtn.setTitle(country, for: .normal)
                   AppSession.share.registerModel.countryId = countryId
               }
        if let dob = data["date_of_birth"] as? String {
            dateofBirthBtn.setTitle(dob, for: .normal)
            AppSession.share.registerModel.dob = dob
        }
        if let email = data["email"] as? String {
            self.email.text = email
            AppSession.share.registerModel.email = email
        }
        if let firstName =  data["firstname"] as? String {
            self.firstName.text = firstName
            AppSession.share.registerModel.firstName = firstName
        }
        if let lastName = data["lastname"] as? String {
            self.lastName.text = lastName
            AppSession.share.registerModel.lastName = lastName
        }
        if let gender = data["gender"] as? String {
            self.genderBtn.setTitle(gender, for: .normal)
            AppSession.share.registerModel.gender = gender
        }
        if let city = data["residential_city"] as? String {
            self.city.text = city
            AppSession.share.registerModel.city = city
        }
          
        if let year = data["interested_year"] as? String {
            self.yearBtn.setTitle(year, for: .normal)
            AppSession.share.registerModel.year = year
        }
        
        if let number = data["mobileNumber"] as? String {
            self.mobile.text = number
            AppSession.share.registerModel.mobile = number
        }
            if let levelOfStudyId = data["apply_education_level_id"] as? String,let title =  data["apply_education_level_title"] as? String{
                self.levelOfStudyBtn.setTitle(title, for: .normal)
                AppSession.share.registerModel.levelOfStudy = levelOfStudyId
            }
            if let courseTypeId = data["apply_course_type_id"] as? String,let courseTypeTitle = data["apply_course_type_title"] as? String {
                self.courseTypeBtn.setTitle(courseTypeTitle, for: .normal)
                AppSession.share.registerModel.courseTypeId = courseTypeId
            }
            if let interestedId = data["interested_category_id"] as? [String], let interestedName = data["interested_category_title"] as? [String] {
                if let id = interestedId.first {
                    AppSession.share.registerModel.fieldOfStudy = id
                }
                if let name = interestedName.first {
                   self.fieldOfStudyBtn.setTitle(name, for: .normal)
                }
            }
            if let interestedId = data["interested_category_id_option2"] as? [String], let interestedName = data["interested_category_option2_title"] as? [String] {
                if let id = interestedId.first {
                    AppSession.share.registerModel.fieldOfStudySecondOption = id
                }
                if let name = interestedName.first {
                   self.fieldOfStudySecondOptionBtn.setTitle(name, for: .normal)
                }
            }
    }
    }
}
*/
