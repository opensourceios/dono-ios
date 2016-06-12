// Dono iOS - Password Derivation Tool
// Copyright (C) 2016  Panos Sakkos
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
    
    @IBAction func keyTextFieldEditingEnd(sender: AnyObject)
    {
        self.keyTextField.secureTextEntry = true
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
