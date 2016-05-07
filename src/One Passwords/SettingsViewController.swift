//
//  SettingsViewController.swift
//  Dono
//
//  Created by Ghost on 5/7/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController
{
    var settings = Settings()
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var rememberKey: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.updateViewWithSettings()
    }
    
    @IBAction func rememberKeyValueChanged(sender: AnyObject)
    {
        self.settings.setRememberKeyValue(self.rememberKey.on)
        
        if (self.rememberKey.on == false)
        {
            let key = PersistableKey()
            key.delete()
        }
    }
    
    func updateViewWithSettings()
    {
        self.rememberKey.on = self.settings.getRememberKeyValue()
    }
}