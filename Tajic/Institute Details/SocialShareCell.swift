//
//  SocialShareCell.swift
//  Unica New
//
//  Created by UNICA on 25/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class SocialShareCell: UITableViewCell {
    var model = InstituteDetailsModel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //***********************************************//
    // MARK: UIButton Action Defined Here 
    //***********************************************//

    @IBAction func facebookBtnTapped(_ sender:UIButton){
           redirectToWeb(model.facebookUrl, type: "FaceBook")
       }

       @IBAction func twitterBtnTapped(_ sender:UIButton){
            redirectToWeb(model.twitterUrl, type: "Twitter")
       }

       @IBAction func linkedInBtnTapped(_ sender:UIButton){
              redirectToWeb(model.linkedinUrl, type: "LinkedIn")
         }

         @IBAction func youTubeBtnTapped(_ sender:UIButton){
              redirectToWeb(model.youtubeUrl, type: "youtTube")
         }
    
   @IBAction func instaBtnTapped(_ sender:UIButton){
        redirectToWeb(model.instagramUrl, type: "Instagram")
    }
}

//***********************************************//
// MARK: URL Link open method
//***********************************************//

extension  SocialShareCell {
    func redirectToWeb (_ urlString:String,type:String) {
        if urlString.isEmpty == false && urlString.isValidURL == true,let Url = URL(string:urlString) {
            switch type {
            case "FaceBook": UIApplication.shared.open(Url, options: [:], completionHandler: nil)
            case "Twitter": UIApplication.shared.open(Url, options: [:], completionHandler: nil)
            case "LinkedIn": UIApplication.shared.open(Url, options: [:], completionHandler: nil)
            default:UIApplication.shared.open(Url, options: [:], completionHandler: nil)
            }
        }
    }
}
