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

import SWRevealViewController
import UIKit

// TODO: This class duplicates code from the DonoViewController.
// Find a way to use a TableViewController that its UIViewController is a DonoViewController.
class DonoTableViewController : UITableViewController, SWRevealViewControllerDelegate
{
    @IBOutlet weak var Open: UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.createRevealViewController()
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
}
