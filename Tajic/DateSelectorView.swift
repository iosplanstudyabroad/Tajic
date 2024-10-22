//
//  DateSelectorView.swift
//  CampusFrance
//
//  Created by UNICA on 17/06/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol dateProtocol {
    func selectedDate(date:Date)
}
class DateSelectorView: UIView {
    var delegate:dateProtocol?
    var selectedDate = Date()
    @IBOutlet var button: [UIButton]!
    
    var isDobValidation = false
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
//    lazy var datePicker: UIDatePicker = {
//        let picker = UIDatePicker()
//        picker.datePickerMode = .date
//        return picker
//    }()
    
    @IBOutlet weak var pickerBackgroundView: UIView!
    var bag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.forEach { (button) in
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.titleLabel?.textColor = UIColor().themeColor()
            button.layer.borderColor = UIColor().themeColor().cgColor
            button.layer.borderWidth = 1
        }
    }
    
  
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        if isDobValidation{
            let difference = calculateDaysBetweenTwoDates(start: selectedDate, end: Date())
            
            if difference < 13 {
                return
            }
        }
        self.delegate?.selectedDate(date: selectedDate)
        self.removeFromSuperview()
    }
  
    
    
    
    private func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .year, in: .era, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .year, in: .era, for: end) else {
            return 0
        }
        return end - start
    }
    

}

extension DateSelectorView {
    func setupPickers() {
        datePicker.setDate(selectedDate, animated:  true)
        datePicker.rx
            .date
            .debug()
            .subscribe(onNext: {  date in
                print(date)
                self.selectedDate = date
                
            })
            .disposed(by: bag)
        datePicker.frame = CGRect(x: CGFloat(0), y:CGFloat(56) , width: CGFloat(pickerBackgroundView.frame.size.width), height: CGFloat(154))
        pickerBackgroundView.addSubview(datePicker)
        pickerBackgroundView.layer.cornerRadius = 5
        pickerBackgroundView.layer.masksToBounds = true
        pickerBackgroundView.layer.borderColor = UIColor().themeColor().cgColor
        pickerBackgroundView.layer.borderWidth = 1
    }
    
}
