//
//  CommonWebVC.swift
//  CampusFrance
//
//  Created by UNICA on 12/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import WebKit
class CommonWebVC: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var downloadBtn:UIButton!
    var urlString   = ""
    var titleString = ""
    var isDownloadEnable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeb()
    }

    func configureWeb(){
        print(urlString)
        downloadBtn.isHidden = true
        if StaticHelper.isInternetConnected {
            webView.navigationDelegate = self
            if urlString.contains(" ") {
                if  let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    if let url = URL(string:urlStr) {
                        let request = URLRequest(url:url )
                        webView.load(request)
                        ActivityView.show()
                    }
                }
            }
            if let url = URL(string:urlString) {
                let request = URLRequest(url:url )
                webView.load(request)
                ActivityView.show()
            }
        }else{
            showAlertMsg(msg:AlertMsg.InternectDisconnectError)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addLeftMenuBtnOnNavigation()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    @IBAction func downloadBtnTapped(_ sender:UIButton){
        DispatchQueue.main.async {
            if self.urlString.contains(" ") {
                if  let urlStr = self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    if let url = URL(string:urlStr) {
                        self.downloadFile(url)
                    }
                }
            }
            if let url = URL(string:self.urlString) {
                self.downloadFile(url)
            }
        }
    }
}
extension CommonWebVC{
    func downloadFile(_ downUrl:URL?){
        
        if let url = downUrl {
    let fileName = String((url.lastPathComponent)) as NSString
    // Create destination URL
            guard   let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL? else{
                print("error ")
                return
            }
    let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
            DispatchQueue.main.async {
            ActivityView.show()
            }
    //Create URL to the source file you want to download
    let fileURL = url
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = URLRequest(url:fileURL)
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        if let tempLocalUrl = tempLocalUrl  { // error == nil
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Successfully downloaded. Status code: \(statusCode)")
            }
            do {
                if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
                do{
                    try FileManager.default.removeItem(atPath: destinationFileUrl.path)
                  }catch{
                     print("Handle Exception")
                  }
                }
                try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                do {
                    //Show UIActivityViewController to save the downloaded file
                    let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    for indexx in 0..<contents.count {
                        if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                            let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                            DispatchQueue.main.async {
                                ActivityView.hide()
                                self.present(activityViewController, animated: true, completion: nil)
                            }
                        }
                    }
                }
                catch (let err) {
                    print("error: \(err)")
                    DispatchQueue.main.async {
                        ActivityView.hide()
                        if let msg = err.localizedDescription as? String {
                            self.showAlert(title: "", message: msg)
                        }
                        
                    }
                }
            } catch (let writeError) {
                print("Error creating a file \(destinationFileUrl) : \(writeError)")
                DispatchQueue.main.async {
                    ActivityView.hide()
                    if let msg = writeError.localizedDescription as? String {
                        self.showAlert(title: "", message: msg)
                    }
                }
            }
        } else {
            print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            DispatchQueue.main.async {
                ActivityView.hide()
                if let msg = error?.localizedDescription as? String {
                    self.showAlert(title: "", message: msg)
                }
                
            }
        }
    }
    task.resume()
        }
        
    }
    
}
extension CommonWebVC:WKNavigationDelegate{
     func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard
                let url = navigationAction.request.url,
                let scheme = url.scheme else {
                    decisionHandler(.cancel)
                    return
            }

            if (scheme.lowercased() == "mailto") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                // here I decide to .cancel, do as you wish
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityView.hide()
        downloadBtn.isHidden = true
        if isDownloadEnable {
            downloadBtn.cornerRadius(downloadBtn.frame.size.height/2)
            downloadBtn.backgroundColor =  UIColor().themeColor()
            downloadBtn.isHidden = false
        }
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here
    //***********************************************//
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addLeftMenuBtnOnNavigation(){
        self.navigationController?.configureNavigation()
        let menuBtn                                             = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "arrow_left.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        menuBtn.frame                                           = CGRect(x: 0, y: 0, width: 45, height: 45)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-100, height: 45))
        leftView.addSubview(menuBtn)
        let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: self.view.frame.size.width-110, height: 45))
        titleLbl.text = titleString
        titleLbl.textColor = UIColor.white
        leftView.addSubview(titleLbl)
        let barBtn                                              = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem                   = barBtn
    }
}
