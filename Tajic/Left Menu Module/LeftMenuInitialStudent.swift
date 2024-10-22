//
//  LeftMenuInitialStudent.swift
//  Unica New
//
//  Created by UNICA on 04/10/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class LeftMenuInitialStudent: SlideMenuController {
    override func awakeFromNib() {
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Student_Home") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "UNStudentLeftMenuVC")   {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }
    override func viewDidLoad() {
        SlideMenuOptions.leftViewWidth     = view.frame.size.width * 0.60
        SlideMenuOptions.contentViewScale   = 1.00
        SlideMenuOptions.contentViewOpacity = 0.0
        SlideMenuOptions.panGesturesEnabled = false
    }
}
