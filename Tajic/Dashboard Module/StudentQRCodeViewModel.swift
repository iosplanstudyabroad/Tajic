//
//  StudentQRCodeViewModel.swift
//  Unica New
//
//  Created by UNICA on 10/10/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class StudentQRCodeViewModel: NSObject {
    func getQrDetail(block:@escaping(_ qrCode:String?,_ qrImage:UIImage?)-> Swift.Void){
        var qrblockString:String?
        var qrCodebBlockImage:UIImage?
        if let qrString =  UserDefaults.standard.object(forKey: "qrString") as? String, let qrData = UserDefaults.standard.object(forKey: "qrImg") as? Data {
             qrblockString = qrString
            let image = UIImage(data: qrData)
                           qrCodebBlockImage = image
            block(qrblockString,qrCodebBlockImage)
        }else{
          getQrCodeDetails(block: block)
        }
    }
    
  private  func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}

//***********************************************//
// MARK: QR Code Service
//***********************************************//
extension StudentQRCodeViewModel{
   private func getQrCodeDetails(block:@escaping(_ qrCode:String?,_ qrImage:UIImage?)-> Swift.Void) {
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
        
     //   let params = ["userid": ""]
        ActivityView.show()
    /*    WebServiceManager.instance.studentGetQRCodeWithDetails(params: params) { (status, json) in
            switch status {
            case StatusCode.Success:
                if let data = json["Payload"] as? [String:Any], let qrString = data["unica_code"] as? String  {
                    if let img = self.createQRFromString(str: qrString) {
                        block(qrString, img)
                    }
                    UserDefaults.standard.set(qrString, forKey: "qrString")
                }
                else{
                    self.showAlertMsg(msg: json["Message"] as! String)
                     block(nil, nil)
                }
                ActivityView.hide()
            case StatusCode.Fail:
                block(nil, nil)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
                block(nil, nil)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:
                break
            }
        }
    */
    }}




extension StudentQRCodeViewModel {
    private func createQRFromString(str: String) -> UIImage? {
        let stringData = str.data(using: .utf8)

        
        // Generate the code image with CIFilter
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(stringData, forKey: "inputMessage")
        
       
        let transform = CGAffineTransform(scaleX: 100, y: 100)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        
        // Change the color using CIFilter
        let colorParameters = [
            "inputColor0": CIColor(color: UIColor().themeColor()), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)

          let qrImg =   UIImage(ciImage: colored)
        if (qrImg.imageAsset != nil) {
            saveImage(qrImage: colored)
            
            return qrImg
        }
        return  nil
        }
    
        /*
        filter.setValue(stringData, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setValue(filter.outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1") // Background white
        colorFilter.setValue(CIColor(red: 32, green: 104, blue: 158), forKey: "inputColor0") // Foreground or the barcode RED

        
       
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        
        
        if let cimg = colorFilter.outputImage {
            let scaledQrImage = cimg.transformed(by: transform)
            let qrImg = UIImage(
                ciImage: scaledQrImage,
                scale: 1.0,
                orientation: UIImage.Orientation.down
            )
            */
        
    
    
    
    private func saveImage (qrImage:CIImage){
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(qrImage, from: qrImage.extent)!
        let image = UIImage.init(cgImage: cgImage)
        if let imageData = image.pngData() {
            UserDefaults.standard.set(imageData, forKey: "qrImg")
            print("QR Image saved")
        }
    }
}

/*
extension UNStudentQRCodeVC {
func addLeftMenuBtnOnNavigation(){
    self.navigationController?.configureNavigation()
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "Menu.png"), for: .normal)
    button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
    button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
    let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
    leftView.addSubview(button)
    let titleLbl = UILabel(frame: CGRect(x: 55, y: 0, width: 200, height: 45))
    titleLbl.text = "My Unica Code"
    titleLbl.textColor = UIColor.white
    leftView.addSubview(titleLbl)
    let barButton = UIBarButtonItem(customView: leftView)
    self.navigationItem.leftBarButtonItem = barButton
}
}
*/
