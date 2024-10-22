//
//  CountryFilterVC.swift
//  Aliff
//
//  Created by Mohit Kumar  on 24/07/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol CountryFilterDelegate {
    func getFilterQueryFeature(_ country: CountryModel)
    func getFilterQueryPerfect(_ country: CountryModel)
    func resetFeatureFilter()
    func resetPerfectMatchFilter()
}
class CountryFilterVC: UIViewController {
    @IBOutlet weak var card:UIView!
    
    @IBOutlet var dashView: UIView!
    @IBOutlet weak var selectCountryBtn:UIButton!
    
    var delegate:CountryFilterDelegate? = nil
    var country =  CountryModel()
    var isPerfectMatch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        dashView.border(1, borderColor: .black)
        if country.id.isEmpty == false {
            self.selectCountryBtn.setTitle(country.name, for: .normal)
        }
    }
    
    @IBAction func closeBtnTapped(_ sender:UIButton){
        self.remove()
    }
    
    @IBAction func   selectCountryBtnTapped(_ sender:UIButton){
        showSelectionPopUp()
    }
    
    
    @IBAction func resetBtnTapped(_ sender:UIButton){
        self.remove()
        if isPerfectMatch {
            delegate?.resetPerfectMatchFilter()
            return
        }
        delegate?.resetFeatureFilter()
    }

    @IBAction func serachBtnTapped(_ sender:UIButton){
           self.remove()
        if isPerfectMatch {
            delegate?.getFilterQueryPerfect(self.country)
            return
        }
        delegate?.getFilterQueryFeature(self.country)
    }
}


extension CountryFilterVC:countryFilterProtocol {
    func getSelectedCountry(_ model: CountryModel) {
        self.country = model
        self.selectCountryBtn.setTitle(model.name, for: .normal)
    }
    
    func showSelectionPopUp(){
        self.view.endEditing(true)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryFilterSelectionVC") as? CountryFilterSelectionVC {
            vc.delegate        = self
            vc.isPerfectMatch = isPerfectMatch
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController?.add(vc)
            }
        }
    }
    
   
}

