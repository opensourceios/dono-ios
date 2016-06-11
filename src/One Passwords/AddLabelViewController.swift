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

    var persistableLabels = PersistableLabels()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableLabels.getAll()
        
        self.newLabelTextField.becomeFirstResponder();        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }

    @IBAction func AddServiceTag(sender: AnyObject)
    {
        var newLabelTextField = self.newLabelTextField.text!
        
        newLabelTextField = self.persistableLabels.add(newLabelTextField)
        
        if (!newLabelTextField.isEmpty)
        {
            showAlert(newLabelTextField + " was added to your Labels!")
        }
        else
        {
            let canonicalLabel = self.persistableLabels.canonical(self.newLabelTextField.text!)

            if (!canonicalLabel.isEmpty)
            {
                showError(canonicalLabel + " is already added to your Labels")
            }
        }
        
        self.newLabelTextField.text = String()
    }    
}