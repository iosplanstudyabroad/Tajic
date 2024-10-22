//
//  HighestLevelCell.swift
//  CampusFrance
//
//  Created by UNICA on 21/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol highestLevelProtocol {
    func getSelectedCourse(model:CourseModel)
    func getSelectedCountryDetails(model:CountryModel)
}
class HighestLevelCell: UITableViewCell {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var upperLbl: UILabel!
    @IBOutlet weak var countryTxt: UITextField!
     var courseArray   = [CourseModel]()
     let countryView   = Bundle.main.loadNibNamed("CountryView", owner: self, options: nil)![0] as? CountryView
     var conuntryArray = [CountryModel]()
     var delegate:highestLevelProtocol?
    var selectedIndex = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func completedOrOnGoingTapped(isCompleted:String){
        switch isCompleted {
            case "":upperLbl.text = "Select your Highest level of Education"
        case "onging":upperLbl.text = "Select the Level of the Ongoing Education"
        case "completed":upperLbl.text = "Select your Highest level of Education"
        default:break
        }
    }
    
    func configureView(){
        cardView.cardView()
        lowerView.layer.cornerRadius = 5
        lowerView.layer.masksToBounds = true
        lowerView.layer.borderColor = UIColor.darkGray.cgColor
        lowerView.layer.borderWidth = 1
        countryTxt.delegate = self
        countryTxt.text = "India"
        let model = CountryModel()
        model.id = "102"
        model.name = "India"
        delegate?.getSelectedCountryDetails(model: model)
    }
    func updateTable(){
        let model = UserModel.getObject()
        if model.profileCompleted == "Y" {
        selectedIndex = AppSession.share.miniProfileModel.firstStep.highEducationId
        }
        
        table.reloadData()
    }
}


extension HighestLevelCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return educationCell(indexPath: indexPath)
    }
    
    private func educationCell(indexPath: IndexPath) -> EducationCell {
        let cell = table.dequeueReusableCell(withIdentifier: "EducationCell") as!EducationCell
       cell.radioMenu.text =   courseArray[indexPath.row].courseName
        
        if selectedIndex == Int(courseArray[indexPath.row].courseId)!  {
            cell.radioImg.image = UIImage(named: "radio_checked")
        }else{
            cell.radioImg.image = UIImage(named: "radio")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = Int(courseArray[indexPath.row].courseId)!
        delegate?.getSelectedCourse(model: courseArray[indexPath.row])
        tableView.reloadData()
    }
}


extension HighestLevelCell{
    func loadviewFromCountryList(array:[CountryModel]){
        countryView!.removeFromSuperview()
        countryView!.delegate            = self
        countryView!.countryArray        = array
        let height                       =  CGFloat(array.count*50)
        let yAxis                        = lowerView.frame.origin.y - height
        let width                        =  countryTxt.frame.size.width
        countryView!.frame               = CGRect(x: CGFloat(30), y: yAxis, width:width, height:height)
        countryView!.configureTableView()
        countryView!.layer.masksToBounds = true
        countryView!.layer.borderColor   = UIColor().themeColor().cgColor
        countryView!.layer.borderWidth   = 1
        self.addSubview(countryView!)
    }
}
extension HighestLevelCell:countryProtocol {
    func selectedCountryDetails(model:CountryModel){
        delegate?.getSelectedCountryDetails(model: model)
         countryTxt.text = model.name
        
    }
}

extension HighestLevelCell:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if result.count > 2 {
           searchCountryName(name:result)
        }
        
        return true
    }
}


extension HighestLevelCell {
    func searchCountryName(name:String) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        let model = UserModel.getObject()
        let params =   ["app_agent_id":model.agentId,"page_number" : "","search_country":name]
        self.conuntryArray.removeAll()
        ActivityView.show()
        WebServiceManager.instance.studentSearchCountryWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any], let countryArray = data["countries"] as? [[String:Any]] {
                    for country in countryArray {
                        let model = CountryModel(with: country)
                        self.conuntryArray.append(model)
                    }
                    self.loadviewFromCountryList(array:self.conuntryArray)
                    print(countryArray)
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





