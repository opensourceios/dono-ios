//
//  NewServiceTagViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import UIKit

class NewServiceTagViewController : UIViewController
{
    var persistableServiceTags = PersistableServiceTags();
    
    @IBOutlet weak var newServiceTag: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableServiceTags.getAll()
        
        self.newServiceTag.becomeFirstResponder();
    }
        
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }

    @IBAction func AddServiceTag(sender: AnyObject)
    {
        let newServiceTag = self.newServiceTag.text!
        
        self.persistableServiceTags.add(newServiceTag)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.loadLabels()
        self.newServiceTag.text = ""
        
        showAlert(newServiceTag + " was added to your Labels!")
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
}