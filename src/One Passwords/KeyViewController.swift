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

class KeyViewController : DonoViewController
{
    @IBOutlet weak var keyTextField: UITextField!
    
    @IBOutlet weak var Open: UIBarButtonItem!

    var settings = Settings()
    var persistableKey = PersistableKey()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.keyTextField.becomeFirstResponder()
        
        //RevealVC Boilerplate
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)

        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.updateKeyInView()
        
        self.addKeyboardToolbar()
        self.addRevealButton()
    }
    
    func updateKeyInView()
    {
        self.keyTextField.text = self.persistableKey.getKey()
    }
    
    func addKeyboardToolbar()
    {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.backgroundColor = DonoViewController.DarkPrimaryColor
        self.keyTextField.inputAccessoryView = keyboardToolbar
    }
    
    func addRevealButton()
    {
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(image: UIImage(named: "eye"), style: .Done, target: self, action: #selector(KeyViewController.hideShowKey(_:)))
        
        (self.keyTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, doneBarButton]
    }
    
    func addHideButton()
    {
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(image: UIImage(named: "eye-off"), style: .Done, target: self, action: #selector(KeyViewController.hideShowKey(_:)))
        
        (self.keyTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, doneBarButton]
    }
    
    @IBAction func hideShowKey(barButtonItem: UIBarButtonItem)
    {
        self.keyTextField.secureTextEntry = !self.keyTextField.secureTextEntry
        
        if (self.keyTextField.secureTextEntry)
        {
            self.addRevealButton()
        }
        else
        {
            self.addHideButton()
        }
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