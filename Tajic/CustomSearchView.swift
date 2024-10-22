//
//  self.SearchView.swift
//  CampusFrance
//
//  Created by UNICA on 11/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

protocol  searchProtocol {
    func getSearchKeyword(keyWord:String)
    func searchViewDismissed()
}
class CustomSearchView: UIView {
var delegate:searchProtocol?
var searchtext      = UITextField()
var navigationFrame = CGRect()
var isSearchAtOnceEnable = false
    
    override func awakeFromNib() {
        
    }

    func confrigureSearchView(){
        searchtext.delegate =  self
        searchtext.autocorrectionType = .no
        self.frame  = CGRect(x: 0, y: -statusBarHeight(), width: navigationFrame.width, height: navigationFrame.height+statusBarHeight())
        self.backgroundColor = .barTintColor
        searchtext.frame =  CGRect(x: 75, y:statusBarHeight(), width: navigationFrame.width - 150, height: navigationFrame.height)
        searchtext.backgroundColor  = UIColor.clear
        searchtext.placeholder = "Search"
        searchtext.clearButtonMode = .whileEditing
        searchtext.textColor = UIColor.white
        searchtext.becomeFirstResponder()
        searchtext.returnKeyType = .search
        searchtext.addTarget(self, action: #selector(searchBtnPressed), for: .editingDidEndOnExit)
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        menuButton.addTarget(self, action: #selector(searchBackBtnTapped), for: .touchUpInside)
        menuButton.frame = CGRect(x: 25, y: statusBarHeight()-3, width: 45, height: 45)
        menuButton.removeFromSuperview()
        self.addSubview(menuButton)
        searchtext.removeFromSuperview()
        self.addSubview(searchtext)
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
}

extension CustomSearchView {
    @objc func searchBtnPressed(_ sender: UITextField){
        if let text = sender.text,text.isEmpty == false {
            delegate?.getSearchKeyword(keyWord: text)
        }else{
            showAlertMsg(msg: "Please enter keyword for search")
        }
    }
    
    @IBAction func searchBackBtnTapped(_ sender: Any) {
       dismiss()
    }
    
    func dismiss(){
        searchtext.text = ""
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { [] in
            self.layoutIfNeeded()
            self.removeFromSuperview()
        }
        delegate?.searchViewDismissed()
    }
}

extension CustomSearchView:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var keyWord = ""
if let text = textField.text,let textRange = Range(range, in: text) {
    keyWord = text.replacingCharacters(in: textRange,with: string)
               }
        keyWord = keyWord.lowercased()
        
        delegate?.getSearchKeyword(keyWord: keyWord)
        return true
        
        if isSearchAtOnceEnable {
            if keyWord.isEmpty {
                delegate?.searchViewDismissed()
                return true
            }
            delegate?.getSearchKeyword(keyWord: keyWord)
        }
        
        print(keyWord)
       return true
    }
    
    
}
