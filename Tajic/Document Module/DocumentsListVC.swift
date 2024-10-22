//
//  DocumentsListVC.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import MobileCoreServices

class DocumentsListVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet var whatsAppBtn: UIButton!
    @IBOutlet var callBtn: UIButton!
    var documentList = [DocumentModel]()
    var picker = UIImagePickerController()
    var selectedImage:UIImage?
    var selectedModel :DocumentModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func configure(){
        documentList = AppSession.share.documentArray
        setupNavigation()
        self.table.reloadData()
        picker.delegate = self
        whatsAppBtn.titleLabel?.numberOfLines = 0
        whatsAppBtn.titleLabel?.textAlignment = .center
        whatsAppBtn.titleLabel?.lineBreakMode = .byWordWrapping
        callBtn.titleLabel?.numberOfLines     = 0
        callBtn.titleLabel?.textAlignment     = .center
        callBtn.titleLabel?.lineBreakMode     = .byWordWrapping
        whatsAppBtn.cornerRadius(10)
        callBtn.cornerRadius(10)
    }
    
    @IBAction func backBtnTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func whatsAppBtnTApped(_ sender: UIButton) {
           let what = AppSession.share.agentWhatsup
           if what.isEmpty == false {
            openWhatsapp(what,"")
           }else{
           showAlertMsg(msg: "Whatsapp number is not present")
        }
       }
    
    
    @IBAction func callBtnTapped(_ sender:UIButton){
        let phone = AppSession.share.agentMobile
        if phone.isEmpty == false {
           callNumber(phoneNumber: phone)
        }else{
            showAlertMsg(msg: "Mobile number is not present")
        }
    }
}

extension DocumentsListVC{
    func openWhatsapp(_ phone:String,_ text:String){
        let urlWhats = "whatsapp://send?phone=\(phone)&abid=12354&text=\(text)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    self.showAlertMsg(msg: "Install Whatsapp")
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    private func callNumber(phoneNumber:String) {
        var number = phoneNumber.replacingOccurrences(of: "+", with: "")
             number = number.replacingOccurrences(of: " ", with: "")
      if let phoneCallURL = URL(string: "tel://\(number)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}
extension DocumentsListVC {
    func setupNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "BackButton.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 180, height: 45))
         titleLbl.text = "Upload Documents"
        titleLbl.textColor = UIColor.white
        titleLbl.font = .systemFont(ofSize: 18)
        leftView.addSubview(titleLbl)
        let rightView = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 45))
        let chatBtn                                        = UIButton(type: .custom)
        chatBtn.frame                                      = CGRect(x: 0, y: 0, width: 45, height: 45)
        rightView.addSubview(chatBtn)
        let rightMenuBtn                                        = UIButton(type: .custom)
       // rightMenuBtn.setImage(UIImage(named: "bell.png"), for: .normal)
       // rightMenuBtn.addTarget(self, action: #selector(callBtnTapped), for: .touchUpInside)
        rightMenuBtn.frame                                      = CGRect(x: 50, y: 0, width: 45, height: 45)
        let unreadLabl = UILabel()
        unreadLabl.frame = CGRect(x: 20, y: 0, width: 26, height: 26)
        unreadLabl.textColor           = UIColor.clear
        unreadLabl.backgroundColor     = UIColor.clear
    
       // let rightBarBtn                                         = UIBarButtonItem(customView: rightView)
      //  self.navigationItem.rightBarButtonItem                  = rightBarBtn
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}

extension DocumentsListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureDocumentCell(tableView, indexPath)
    }

    func configureDocumentCell(_ table: UITableView,_ index: IndexPath)-> DocumentsListCell {
        let cell = table.dequeueReusableCell(withIdentifier: "DocumentsListCell") as! DocumentsListCell
        cell.delegate = self
        cell.configure(documentList[index.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docUrl = documentList[indexPath.row].url
        if docUrl.isEmpty == false && docUrl.isValidURL == true {
            self.commonWeb(model:documentList[indexPath.row] )
        }
    }
}
extension DocumentsListVC:DocumentDelegate {
    func getSelectedDocument(model:DocumentModel){
        self.selectedModel = model
        showOptionAlert()
    }
    
    func commonWeb(model:DocumentModel){
        if let nav = slideMenuController()?.mainViewController as? UINavigationController {
        if let vc          = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommonWebVC") as? CommonWebVC {
            vc.titleString = model.name
            vc.urlString   = model.url
            nav.pushViewController(vc, animated: true)
           
            }}
    }
}
extension DocumentsListVC{
    func showOptionAlert(){
        let alertVC = UIAlertController(title: "Choose an option", message: "", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Images", style: .default) { (action) in
            self.showPickerAlert()
            }
        
        let galleryAction = UIAlertAction(title: "Documents", style: .default) { (action) in
            self.documentViewer()
            
        }
           
          
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(galleryAction)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension DocumentsListVC:UIDocumentPickerDelegate {
       func documentViewer() {
           let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
           importMenu.delegate = self
           importMenu.modalPresentationStyle = .popover
           self.present(importMenu, animated: true, completion: nil)
       }
       
       
       func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
           guard let docURL = urls.first else {
               return
           }
        let docString =    docURL.absoluteString.split(separator: ".").last
        
          
        
   do {

        // note it runs in current thread

       let data = try Data(contentsOf:docURL, options: [.alwaysMapped , .uncached ] )

       print(data)

     let ext = String(docString!)
    uploadDocAndPdf(data: data, ext: ext)
   }
   catch {

       print(error)
   }
    
    
    
    }
       
       
       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           print("view was cancelled")
           dismiss(animated: true, completion: nil)
       }
}

//***********************************************//
// MARK: Image Picker Defined Here
//***********************************************//
extension DocumentsListVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
extension DocumentsListVC:TOCropViewControllerDelegate {
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
        self.picker.dismiss(animated: true, completion: nil)
        cropViewController.dismiss(animated: true, completion: nil)
        self.uploadImage(image)
    }
}

extension DocumentsListVC {
    func uploadDocAndPdf(data:Data,ext:String){
        guard let sModel = self.selectedModel else{
            return
        }
        let model = DocumentViewModel()
        
        model.uploadpdfDocs(data, ext: ext, sModel) { (code, docArray) in
            print(docArray)
            DispatchQueue.main.async {
                if docArray.isEmpty == false {
                    AppSession.share.documentArray = docArray
                    self.configure()
                }
            }
        }
    }
    
    func uploadImage(_ image:UIImage?){
        guard let sModel = self.selectedModel else{
            return
        }
        let model = DocumentViewModel()
        model.uplaodDocuments(image, sModel) { (code, docArray) in
            print(docArray)
            DispatchQueue.main.async {
                if docArray.isEmpty == false {
                    AppSession.share.documentArray = docArray
                    self.configure()
                }
            }
        }
    }
}
