//
//  SettingsViewController.swift
//  Dono
//
//  Created by Ghost on 5/7/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import UIKit
import Foundation
import PasscodeLock
import SWRevealViewController

class SettingsViewController : DonoViewController
{
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var rememberKey: UISwitch!
    
    @IBOutlet weak var passcodeLock: UISwitch!

    var settings = Settings()

    let configuration: PasscodeLockConfigurationType
    
    init(configuration: PasscodeLockConfigurationType)
    {
        self.configuration = configuration
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        let repository = UserDefaultsPasscodeRepository()
        configuration = PasscodeLockConfiguration(repository: repository)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //RevealVC Boilerplate
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.updateViewWithSettings()
    }
    
    @IBAction func rememberKeyValueChanged(sender: AnyObject)
    {
        self.settings.setRememberKeyValue(self.rememberKey.on)

        let key = PersistableKey()

        if (self.rememberKey.on)
        {
            key.save()
        }
        else
        {
            key.delete()
        }
    }
    
    @IBAction func passcodeLockValueChanged(sender: AnyObject)
    {
        let passcodeVC: PasscodeLockViewController
        
        if (self.passcodeLock.on)
        {
            passcodeVC = PasscodeLockViewController(state: .SetPasscode, configuration: configuration)

            passcodeVC.successCallback = { lock in
                
                self.updateViewWithSettings()
            }
        }
        else
        {
            passcodeVC = PasscodeLockViewController(state: .RemovePasscode, configuration: configuration)
            
            passcodeVC.successCallback = { lock in
                
                lock.repository.deletePasscode()

                self.updateViewWithSettings()
            }
        }
        
        presentViewController(passcodeVC, animated: true, completion: { self.updateViewWithSettings() } )
    }
    
    func updateViewWithSettings()
    {
        self.rememberKey.on = self.settings.getRememberKeyValue()
        self.passcodeLock.on = self.configuration.repository.hasPasscode
    }
}