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
import Foundation
import SWRevealViewController
import UIKit

class AddLabelViewController : DonoViewController
{
    @IBOutlet weak var newLabelTextField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableLabels.getAll()
        
        self.newLabelTextField.becomeFirstResponder()

        self.createKeyboardToolbar()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        self.newLabelTextField.text = String()
        
        self.view.endEditing(true)
    }

    @IBAction func addLabel(sender: AnyObject)
    {
        self.view.endEditing(true)
        
        var newLabelTextField = self.newLabelTextField.text!
        
        newLabelTextField = self.persistableLabels.add(newLabelTextField)
        
        if (!newLabelTextField.isEmpty)
        {
            self.showAlert(newLabelTextField + " was added to your Labels!")
        }
        else
        {
            let canonicalLabel = self.persistableLabels.canonical(self.newLabelTextField.text!)

            if (!canonicalLabel.isEmpty)
            {
                self.showError(canonicalLabel + " is already added to your Labels")
            }
        }
        
        self.newLabelTextField.text = String()
    }
    
    private func createKeyboardToolbar()
    {
        self.newLabelTextField.inputAccessoryView = self.donoViewFactory.makeKeyboardToolbar()
        
        let flexBarButton = self.donoViewFactory.makeFlexBarButton()
        
        let addButton = self.donoViewFactory.makeKeyboardToolbarButton(
            DonoViewController.PlusImage!,
            target: self,
            action: #selector(AddLabelViewController.addLabel(_:)))
        
        (self.newLabelTextField.inputAccessoryView as! UIToolbar).items = [flexBarButton, addButton]
    }
}