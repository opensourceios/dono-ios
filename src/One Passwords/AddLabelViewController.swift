//
//  NewServiceTagViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import Foundation
import SWRevealViewController
import UIKit

class AddLabelViewController : UIViewController
{
    var persistableLabels = PersistableLabels()
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var newServiceTag: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableLabels.getAll()
        
        self.newServiceTag.becomeFirstResponder();
        
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }

    @IBAction func AddServiceTag(sender: AnyObject)
    {
        var newServiceTag = self.newServiceTag.text!
        
        newServiceTag = self.persistableLabels.add(newServiceTag)
        
        if (!newServiceTag.isEmpty)
        {
            showAlert(newServiceTag + " was added to your Labels!")
        }
        else
        {
            let canonicalLabel = self.persistableLabels.canonical(self.newServiceTag.text!)

            if (!canonicalLabel.isEmpty)
            {
                showError(canonicalLabel + " is already added to your Labels")
            }
        }
        
        self.newServiceTag.text = ""
    }    
}