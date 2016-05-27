//
//  KeyViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import DonoCore
import Foundation
import SWRevealViewController
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
        
        if (key.characters.count < Dono.MIN_KEY_LENGTH)
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
}
