//
//  DonoViewController.swift
//  Dono
//
//  Created by Ghost on 6/5/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import UIKit

class DonoViewController : UIViewController
{
    static var DarkPrimaryColor = DodoColor.fromHexString("#1976d2")
    
    static var PrimaryColor = DodoColor.fromHexString("#2196f3")
    
    static var AccentColor = DodoColor.fromHexString("#03a9f4")
    
    static var SecondaryText = DodoColor.fromHexString("#E3E3E3")

    static var Red = DodoColor.fromHexString("#f44336")

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Setup swipe right gesture to open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}

extension UIViewController
{
    func showAlert(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DonoViewController.PrimaryColor
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
    
    func showError(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DonoViewController.Red
        self.view.dodo.style.bar.hideAfterDelaySeconds = 5
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
}
