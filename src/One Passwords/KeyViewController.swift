//
//  KeyViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import UIKit

class KeyViewController : UIViewController
{
    var settings = Settings()
    var persistableKey = PersistableKey()
    
    @IBOutlet weak var keyTextField: UITextField!
    
    @IBOutlet weak var Open: UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.keyTextField.text = self.persistableKey.getKey()
        self.keyTextField.becomeFirstResponder()
        
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)

        self.view.endEditing(true)
    }
    
    @IBAction func SaveKey(sender: AnyObject)
    {
        let key = self.keyTextField.text!
        
        if (key.characters.count < OnePasswords.MIN_KEY_LENGTH)
        {
            showError("Your Key has to be longer than 16 characters")

            self.keyTextField.text = self.persistableKey.getKey()
            
            return
        }
        
        if (key == self.persistableKey.getKey())
        {
            return
        }
        
        self.persistableKey.setkey(key, remember: self.settings.getRememberKeyValue())

        self.showAlert("Your Key was updated!")
    }
    
    private func showAlert(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#2196f3")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.hideOnTap = true
        
        self.view.dodo.show(message);
    }

    private func showError(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#f44336")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 5
        self.view.dodo.style.bar.hideOnTap = true
        
        self.view.dodo.show(message);
    }
}
