// Dono iOS - Password Derivation Tool
// Copyright (C) 2016  Dono - Password Derivation Tool
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

class KeyViewController : DonoViewController, UITextFieldDelegate
{
    @IBOutlet weak var keyTextField: UITextField!
    
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
        
        self.view.endEditing(true)
    }
    
    @IBAction func saveKey(sender: AnyObject)
    {
        self.view.endEditing(true)
        
        let key = self.keyTextField.text!
        
        if (key.characters.count < Dono.MIN_KEY_LENGTH)
        {
            showError("Your Key has to be longer than " + String(Dono.MIN_KEY_LENGTH - 1) + " characters")

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
        // Update the text of the TextField in order to update
        // the font of the Text as well
        let currentKey = self.keyTextField.text
        self.keyTextField.text = String()
        
        self.keyTextField.secureTextEntry = !self.keyTextField.secureTextEntry
        
        // Restore the Key in order to update its font as well
        self.keyTextField.text = currentKey
        
        self.updateVisibilityButtonImage()
    }
    
    @IBAction func keyTextFieldEditingEnd(sender: AnyObject)
    {
        self.keyTextField.secureTextEntry = true
        
        self.updateVisibilityButtonImage()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.saveKey(self)
        
        return true
    }

    private func updateKeyTextField()
    {
        self.keyTextField.secureTextEntry = true
        
        self.keyTextField.text = self.persistableKey.getKey()
    }
    
    private func createKeyboardToolbar()
    {
        self.keyTextField.inputAccessoryView = self.donoViewFactory.makeKeyboardToolbar()
        
        let flexBarButton = self.donoViewFactory.makeFlexBarButton()
        
        let doneButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.CheckCircleImage!,
            target: self,
            action: #selector(KeyViewController.saveKey(_:)))

        let keyVisibilityButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.EyeImage!,
            target: self,
            action: #selector(KeyViewController.hideShowKey(_:)))

        (self.keyTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, doneButton, keyVisibilityButton]
    }
    
    private func updateVisibilityButtonImage()
    {
        let button = (self.keyTextField.inputAccessoryView as! UIToolbar).items?.last
        
        if (self.keyTextField.secureTextEntry)
        {
            let img = DonoViewController.EyeImage!.imageWithRenderingMode(.AlwaysOriginal)
            
            button?.image = img
        }
        else
        {
            let img = DonoViewController.EyeOffImage!.imageWithRenderingMode(.AlwaysOriginal)

            button?.image = img
        }
    }
}
