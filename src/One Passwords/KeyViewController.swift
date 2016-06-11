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
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.updateKeyTextField()
        
        self.keyTextField.becomeFirstResponder()
        
        self.createKeyboardToolbar()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        self.updateKeyTextField()
        
        self.addRevealButton()

        self.view.endEditing(true)
    }
    
    @IBAction func saveKey(sender: AnyObject)
    {
        self.view.endEditing(true)
        
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
    
    private func updateKeyTextField()
    {
        self.keyTextField.secureTextEntry = true
        self.keyTextField.text = self.persistableKey.getKey()
    }
    
    private func createKeyboardToolbar()
    {
        self.keyTextField.inputAccessoryView = self.donoViewFactory.makeKeyboardToolbar()
        
        self.addRevealButton()
    }
    
    // TODO: Don't recreate all the buttons
    private func addRevealButton()
    {
        let flexBarButton = self.donoViewFactory.makeFlexBarButton()

        let doneButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.CheckCircleImage!,
            target: self,
            action: #selector(KeyViewController.saveKey(_:)))

        let revealKeyButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.EyeImage!,
            target: self,
            action: #selector(KeyViewController.hideShowKey(_:)))
        
        (self.keyTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, doneButton, revealKeyButton]
    }
    
    // TODO: Don't recreate all the buttons
    private func addHideButton()
    {
        let flexBarButton = self.donoViewFactory.makeFlexBarButton()
        
        let hideKeyButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.EyeOffImage!,
            target: self,
            action: #selector(KeyViewController.hideShowKey(_:)))

        
        (self.keyTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, hideKeyButton]
    }
}
