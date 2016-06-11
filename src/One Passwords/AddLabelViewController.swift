//
//  newLabelTextFieldViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

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