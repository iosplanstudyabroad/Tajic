//
//  ProfileQRCodeCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 13/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit

class ProfileQRCodeCell: UITableViewCell {
    @IBOutlet var qrImage: UIImageView!
    @IBOutlet var qrCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

     func configure(_ model:ProfileEnquiryModel){
        self.qrCode.text = model.qrCode
        if model.qrCode.isEmpty == false {
            if let qr = createQRFromString(str: model.qrCode) {
                qrImage.image = qr
            }
        }
       }
}


extension ProfileQRCodeCell{
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
    // saveImage(qrImage: colored)
     
     return qrImg
 }
 return  nil
 }
}
