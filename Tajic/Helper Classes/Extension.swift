//
//  GTExtention.swift
//  gotrack
//
//  Created by Mohit Kumar on 15/02/18.
//  Copyright © 2018 Unica Solutions Pvt Ltd. All rights reserved.
//

import UIKit

//===========================================================
//MARK: - UIColor Extension
//===========================================================
extension UIColor {
    static var themeColor: UIColor{
        return hexToColor("0000BA")
    }
    func gerdaintColors()-> [UIColor]? {
        return [ UIColor(red: 255, green: 255, blue: 255, alpha: 1),
                 UIColor(red: 210/255, green: 229/255, blue: 251/255, alpha: 1)]
    }
    
    static var barTintColor:UIColor{
       return hexToColor("0000BA")
   }
    
    func lightTheme()->UIColor {
      //return hexStringToUIColor(hex: "d3d6db")
        //  72a3f7
        return hexStringToUIColor(hex: "9B9B9B")
    }
   
    func themeColor()-> UIColor{
         return hexStringToUIColor(hex:"0000BA")
    }
    
    func darkThemeColor()-> UIColor{
        return hexStringToUIColor(hex:"024684")
    }
    func selectionColor()-> UIColor{
        return hexStringToUIColor(hex:"EF4135")
    }
    
    
  //  func rareTheme()-> UIColor{
  //     return hexStringToUIColor(hex: "D7EBFB")
  //  }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
   static func hexToColor(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    
    
    
}



//===========================================================
//MARK: - String  Extension
//===========================================================

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
extension String {
    var isValidEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
//    var localizable:String {
//        return NSLocalizedString(self, comment: "")
//    }
    
  
    
    
    
    func height(constraintedWidth width: CGFloat, font: UIFont,text:String) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    
    
    func heightForHtmlString(font:UIFont, width:CGFloat) -> CGFloat{
        let string = NSMutableAttributedString(string:self )
        let label:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.attributedText = string as NSAttributedString
        label.sizeToFit()
        return label.frame.height
    }
    
    
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
           let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

           return ceil(boundingBox.width)
       }
    
    /*
    var localizable: String {
        
        var defaultLang = Language.english.rawValue
        
        if let str = UserDefaults.standard.object(forKey: "appleLanguagesKey") as? String {
            let value = Language(rawValue: str)
            value?.semantic
           defaultLang = str
        }
        guard let path = Bundle.main.path(forResource:defaultLang , ofType: "lproj"), let bundle     = Bundle(path: path) else {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    
    */
    
    
    /*
    var localized: String {
        guard let path = Bundle.main.path(forResource:    Locale.current.regionCode?.lowercased(), ofType: "lproj"), let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
  */
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes","Y", "1":
            return true
        case "False", "false", "no","N", "0":
            return false
        default:
            return nil
        }
    }
}

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
      
    }

}

extension RangeExpression where Bound == String.Index  {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}



//===========================================================
//MARK: - UIView Extension
//===========================================================
extension UIView {
    var instPlaceHolder:UIImage?{
        if let image = UIImage(named: "instPh.png") {
            return image
        }
        return nil
    }
    
    var stuPlaceHolder:UIImage?{
        if let image = UIImage(named: "ph.png") {
            return image
        }
        return nil
    }
    var uncheckSquare:UIImage?{
        if let image = UIImage(named: "squareunchacked.png") {
            return image
        }
        return nil
    }
    

    var checkSquare:UIImage?{
        if let image = UIImage(named: "squrechecked.png") {
            return image
        }
        return nil
    }
    //radio_checked
    var radioUnChecked:UIImage?{
        if let image = UIImage(named: "radio.png") {
            return image
        }
        return nil
    }
    
    var radioChecked:UIImage?{
        if let image = UIImage(named: "radio_checked.png") {
            return image
        }
        return nil
    }
    
    var unFavoriteImg:UIImage? {
        if let image = UIImage(named: "favorite.png") {
            return image
        }
        return nil
    }
    
    var favoriteImg:UIImage? {
        if let image = UIImage(named: "favorite_filled.png") {
            return image
        }
        return nil
    }
    
    
    func reload(tableView: UITableView) {
        UIView.performWithoutAnimation {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
            tableView.setContentOffset(contentOffset, animated: false)
        }
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    /*
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line                                       = UIView(frame : CGRect(x : 0.0, y : 0.0, width : bounds.width, height : newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor                           = borderColor
            line.tag                                       = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            line.tag = 110
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    func removeborder() {
        for view in self.subviews {
            if view.tag == 110  {
                view.removeFromSuperview()
            }
            
        }
    }
   */
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionFlipFromTop, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionFlipFromBottom, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    
    func updateLayerProperties(with:UIColor) {
        self.layer.shadowColor = with.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    func cornerRadius(_ radius:CGFloat) -> Void {
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }
    
    func border(_ width:CGFloat, borderColor:UIColor) -> Void {
        self.layer.borderWidth   = width
        self.layer.borderColor   = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func shadows(_ color:UIColor, cornerRadius:CGFloat) -> Void {
        self.layer.masksToBounds = false
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOffset  = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius  = 4.0
        self.layer.cornerRadius  = cornerRadius
    }
    
    func shadowWithBular(shadowColor:UIColor, cornerRadius:CGFloat){
        //       // viewShadow.backgroundColor = UIColor.yellow
        //        self.layer.shadowColor   = shadowColor.cgColor
        //        self.layer.shadowOpacity = 0.7
        //        self.layer.shadowOffset  = CGSize.zero
        //        self.layer.shadowRadius  = cornerRadius
        //        self.layer.cornerRadius  = cornerRadius
        
        
        self.layer.cornerRadius = 5
        
        // border
        self.layer.borderWidth  = 1.0
        self.layer.borderColor  = shadowColor.cgColor
        
        // shadow
        self.layer.shadowColor  = shadowColor.cgColor
        self.layer.shadowOffset  = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity  = 0.7
        self.layer.shadowRadius   = 5.0
        
    }
    
    func dropShadow(shadowColor:UIColor, shadowRadius:Float){
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
    
    
    func setUpViewWithParameters(borderWidth: CGFloat,borderColor:UIColor){
            self.layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds      = true
            self.layer.borderColor  = borderColor.cgColor
            self.layer.borderWidth  = borderWidth
    }
    
    
    func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
   
    
}
//===========================================================
//MARK: - UITextField Extension
//===========================================================
extension UITextField{
    /*
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }*/
}

//===========================================================
//MARK: - UIFont Extension
//===========================================================
extension UIFont {
    static func fontAvenir(ofSize size:CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
}


class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
//===========================================================
//MARK: - UIView Controller Extention
//===========================================================
extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }
    /*
    func moveToHomeVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(vc: .Home)
    }
    */
    
    func addChildVC(content: UIViewController) {
        addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    func removeChildVC(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    
    func showAlertMsg(msg:String) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle:.alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    func openMap(){
        if   let cord = LocationManger.share.currentLatLong {
            let model = UserModel.getObject()
            let directionsURL = "http://maps.apple.com/?saddr=\(cord.latitude),\(cord.longitude)&daddr=\(model.eventLatitude),\(model.eventLongitude)"
            guard let url = URL(string: directionsURL) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    */
    
    /*
    func moveToViewCOntrollers(index:Int, model:MenuModel?){
        defer {
            if index != 5 {
                self.slideMenuController()?.closeLeft()
            }
            
        }
        switch index {
        case 1:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                nav.popToRootViewController(animated: false)
            }
            
        case 2:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC")as! QRCodeVC
                if nav.topViewController is QRCodeVC == false {
                    nav.pushViewController(vc, animated: false)
                }
            }
            
        case 3:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCourseVC")as! SearchCourseVC
                if nav.topViewController is SearchCourseVC == false {
                    nav.pushViewController(vc, animated: false)
                }
            }
            
        case 4:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchEventVC")as! SearchEventVC
                if nav.topViewController is SearchEventVC == false {
                    nav.pushViewController(vc, animated: false)
                }
            }
        case 5: //  events
            break
        case 8:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SortListedCourseVC")as! SortListedCourseVC
                if nav.topViewController is SortListedCourseVC == false {
                    nav.pushViewController(vc, animated: false)
                }
            }
        case 9: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GeneralInfoVC")as! GeneralInfoVC
            if nav.topViewController is GeneralInfoVC == false {
                nav.pushViewController(vc, animated: false)
            }
        }
           
        case 10 : if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as! CommonWebVC
            if  let mod = model {
                if mod.linkOpenType == "EWeb" {
                    if mod.url.isEmpty == false && mod.url.isValidURL == true {
                        if let url = URL(string: mod.url){
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    return
                }else {
                    vc.titleString = mod.leftMenuTitle
                    vc.urlString = mod.url
                }
               
            }
           
            nav.pushViewController(vc, animated: false)
            }
            
            
        case  11:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC")as! SettingVC
                if nav.topViewController is SettingVC == false {
                    nav.pushViewController(vc, animated: false)
                }}
            
            
        case 12: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CFIInterestedStudentListVC")as! CFIInterestedStudentListVC
            nav.pushViewController(vc, animated: false)
            }
        case 17: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as! CommonWebVC
            if let mod = model {
                if mod.linkOpenType == "EWeb" {
                    if mod.url.isEmpty == false && mod.url.isValidURL == true {
                        if let url = URL(string: mod.url){
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    return
                }else {
                    vc.titleString = mod.leftMenuTitle
                    vc.urlString = mod.url
                }
               
            }
            nav.pushViewController(vc, animated: false)
        }
       
        case 19: if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as! CommonWebVC
           if let mod = model {
               if mod.linkOpenType == "EWeb" {
                   if mod.url.isEmpty == false && mod.url.isValidURL == true {
                       if let url = URL(string: mod.url){
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                       }
                   }
                   return
               }else {
                   vc.titleString = mod.leftMenuTitle
                   vc.urlString = mod.url
               }
              
           }
         
             nav.pushViewController(vc, animated: false)
        }
            break
        case 20:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as! CommonWebVC
           if let mod = model {
               if mod.linkOpenType == "EWeb" {
                   if mod.url.isEmpty == false && mod.url.isValidURL == true {
                       if let url = URL(string: mod.url){
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                       }
                   }
                   return
               }else {
                   vc.titleString = mod.leftMenuTitle
                   vc.urlString = mod.url
               }
              
           }
             nav.pushViewController(vc, animated: false)
        }
        case 22:
            if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CFIScannedStudentListVC")as! CFIScannedStudentListVC
                if nav.topViewController is CFIScannedStudentListVC == false {
                    nav.pushViewController(vc, animated: false)
                }}
        case 24:
                if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScannedInstitutionListVC")as! ScannedInstitutionListVC
                    if nav.topViewController is ScannedInstitutionListVC == false {
                        nav.pushViewController(vc, animated: false)
                    }
            }
            
            case 25:
                if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScannedByStudentVC")as! ScannedByStudentVC
                    if nav.topViewController is ScannedByStudentVC == false {
                        nav.pushViewController(vc, animated: false)
                    }
            }
            
            // action = 25;
            case 26:if let nav = slideMenuController()?.mainViewController as? UINavigationController {
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonWebVC")as! CommonWebVC
                      if let mod = model {
                          if mod.linkOpenType == "EWeb" {
                              if mod.url.isEmpty == false && mod.url.isValidURL == true {
                                  if let url = URL(string: mod.url){
                                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                  }
                              }
                              return
                          }else {
                              vc.titleString = mod.leftMenuTitle
                              vc.urlString = mod.url
                          }
                      }
                        nav.pushViewController(vc, animated: false)
                   }
        default:break
        }
    }
    
    */
}


extension ISO8601DateFormatter {
    func convertDate(_ date: Date) -> String
    {
        self.formatOptions = [.withFullDate]
        let converted      = self.string(from: date)
        return converted
    }
}


extension UIImageView {
    public func imageFromURL(urlString: URL) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: urlString, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}



protocol genderSelectionProtocol {
 func getSelectedGender(gender:String)
}

protocol eventSelectionProtocol {
  func getSelectedEventWithDetails(eventName:String,eventId:Int)
}

protocol languageAndSourceProtocol {
    func getSelectedProficiencyLevel(with model:(String,Int))
    func getSelectedSelectedSourceOfInformation(with model:(String,Int))
}

protocol templateActionProtocol {
    func  getSelectedDataWithDetails(text:String,id:Int,tag:Int)
}



extension UIButton {
    func setUpCameraButton(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 4
        self.backgroundColor =
            UIColor(red: 215/255, green: 235/255, blue: 251/255, alpha: 1)
    }
    
    
}


    
    
    extension UIViewController {
        func setTitle(_ title: String) {
            let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            titleLbl.text = title
            titleLbl.textColor = UIColor.white
            titleLbl.textAlignment = .left
            titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
            navigationItem.titleView = titleLbl
        }
        
    }
    




class customBtn:UIButton{
   var  actionId = 0
}




private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}


extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}


extension UIView {
    
    func showView(completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func hideView(completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
}


extension UIView {
    func commonDesingnView(){
        self.layer.cornerRadius  = 2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.5, height : 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius  = 5.0
        self.layer.masksToBounds = false
    }
    
    func cardView(){
        self.layer.cornerRadius  = 2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.3, height : 0.2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius  = 2.0
        self.layer.masksToBounds = false
    }
    
    func cardViewWithCircle(){
        self.layer.cornerRadius  = self.frame.size.height/2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.3, height : 0.2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius  = 2.0
        self.layer.masksToBounds = false
    }
    
    func cardViewWithCornerRadius(_ radius:CGFloat){
           self.layer.cornerRadius  = radius
           self.layer.shadowColor   = UIColor.black.cgColor
           self.layer.shadowOffset  = CGSize(width : 0.3, height : 0.2)
           self.layer.shadowOpacity = 0.3
           self.layer.shadowRadius  = 2.0
           self.layer.masksToBounds = false
       }
    
    
    func setUpView(bWidth: CGFloat,bColor:UIColor,rCorner:CGFloat){
        self.layer.cornerRadius = rCorner
        self.clipsToBounds      = true
        self.layer.borderColor  = bColor.cgColor
        self.layer.borderWidth  = bWidth
    }
}






/*
extension UIView {
    func commonDesingnView(){
        self.layer.cornerRadius  = 2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.5, height : 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius  = 5.0
        self.layer.masksToBounds = false
    }
    
    func cardView(){
        self.layer.cornerRadius  = 2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.3, height : 0.2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius  = 2.0
        self.layer.masksToBounds = false
    }
    
    func cardViewWithCircle(){
        self.layer.cornerRadius  = self.frame.size.height/2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width : 0.3, height : 0.2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius  = 2.0
        self.layer.masksToBounds = false
    }
    
    func setUpView(bWidth: CGFloat,bColor:UIColor,rCorner:CGFloat){
        self.layer.cornerRadius = rCorner
        self.clipsToBounds      = true
        self.layer.borderColor  = bColor.cgColor
        self.layer.borderWidth  = bWidth
    }
}
*/
extension UIImageView {
    func makeBlur()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

extension UINavigationController {
    func configureNavigation(){
        self.isNavigationBarHidden             = false
       // self.navigationBar.barTintColor        = .barTintColor
       // self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      //  self.navigationBar.tintColor           = UIColor.white
    }
    
//
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
//        return topViewController?.preferredStatusBarStyle ?? .lightContent
//    }
//
//
//    open override var childForStatusBarStyle: UIViewController? {
//        return visibleViewController
//    }
//
    
    
    
    open override var preferredStatusBarStyle:UIStatusBarStyle {
          if let rootViewController = self.viewControllers.first {
            return rootViewController.preferredStatusBarStyle
          }
        return super.preferredStatusBarStyle
      }
    
    
    
    
    
}


extension UIViewController {
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion:   nil)
    }
    
   
}

public extension UIViewController {
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}

/*
extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

*/


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


extension NSObject {
    func classNameAsString(obj: Any)  {
        
        print(String(describing: type(of: obj)))
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}



extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
