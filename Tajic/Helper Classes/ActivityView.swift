//
//  ActivityView.swift
//  NIXT
//
//  Created by Dex_Mac2 on 6/6/17.
//  Copyright © 2017 Dex_Mac2. All rights reserved.
//

import UIKit
import MBProgressHUD

class ActivityView: NSObject {
    static func show(){
        self.hide()
        
        
        if  let key = UIApplication.shared.keyWindow {
            let hud             = MBProgressHUD.showAdded(to: key, animated: true)
                   hud.bezelView.style = .solidColor
                   hud.bezelView.color = UIColor.clear
                   hud.bezelView.backgroundColor = UIColor.clear
                hud.contentColor    = UIColor().themeColor()
        }
        
        
    }
    static func hide(){
       
       if  let window = UIApplication.shared.keyWindow {
         MBProgressHUD.hide(for: window, animated: true)
        }
        
            
      //  MBProgressHUD.hide(for: appDelegate.window!, animated: true)
        
    }
    static func showToast(msg:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let hud             = MBProgressHUD.showAdded(to: appDelegate.window!, animated: true)
            hud.mode = .text
            hud.label.text = msg
            hud.label.numberOfLines = 0
            hud.margin = 10.0
            let const = (UIScreen.main.bounds.height/2)/2
            hud.offset.y = const+50
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 0.5)
    }
}
