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
import SWRevealViewController
import UIKit

class DonoViewController : UIViewController, SWRevealViewControllerDelegate
{
    // Palette
    static var DarkPrimaryColor = DodoColor.fromHexString("#1976d2")
    
    static var PrimaryColor = DodoColor.fromHexString("#2196f3")
    
    static var AccentColor = DodoColor.fromHexString("#03a9f4")
    
    static var SecondaryText = DodoColor.fromHexString("#e3e3e3")

    static var Red = DodoColor.fromHexString("#f44336")

    // Images
    static var DeleteSweepImage = UIImage(named: "delete-sweep")
    
    static var EyeImage = UIImage(named: "eye")
    
    static var EyeOffImage = UIImage(named: "eye-off")

    static var CheckCircleImage = UIImage(named: "check-circle")

    static var PlusImage = UIImage(named: "plus")

    static var Copyright = "Copyright Dono - Password Derivation Tool\nLicensed under the GPLv3"

    // Outlets
    @IBOutlet weak var Open: UIBarButtonItem!
    
    // Dono classes
    var settings = Settings()
    
    var persistableKey = PersistableKey()

    var persistableLabels = PersistableLabels()

    var donoViewFactory = DonoViewFactory()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.createRevealViewController()
        
        self.setupNavigationBar()
    }
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition)
    {
        // Hide Keyboard when Reveal View opens
        self.view.endEditing(true)
    }
        
    func copyToPasteboard(text: String)
    {
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = text
    }
    
    private func createRevealViewController()
    {
        //RevealVC Boilerplate
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Setup swipe right gesture to open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Hide keyboard when the menu appears
        revealViewController().delegate = self
    }
    
    private func setupNavigationBar()
    {
        // Remove black line from Navigation Bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
}

extension UIViewController
{
    func showAlert(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DonoViewController.PrimaryColor
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
    
    func showError(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DonoViewController.Red
        self.view.dodo.style.bar.hideAfterDelaySeconds = 5
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
}
