//
//  NewServiceTagViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/9/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import UIKit
import Foundation

class AddLabelViewController : UIViewController
{
    var persistableServiceTags = PersistableServiceTags();
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var newServiceTag: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableServiceTags.getAll()
        
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
        
        newServiceTag = self.persistableServiceTags.add(newServiceTag)
        
        if (!newServiceTag.isEmpty)
        {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            appDelegate.loadLabels()
            
            showAlert(newServiceTag + " was added to your Labels!")
        }
        else
        {
            let canonicalLabel = self.persistableServiceTags.canonical(self.newServiceTag.text!)

            if (!canonicalLabel.isEmpty)
            {
                showError(canonicalLabel + " is already added to your Labels")
            }
        }
        
        self.newServiceTag.text = ""
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
    
    private func showError(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#f44336")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 5
        self.view.dodo.style.bar.hideOnTap = true
        
        self.view.dodo.show(message);
    }
}