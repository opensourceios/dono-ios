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
import Foundation

class BackTableViewController : UITableViewController
{
    private static let LabelsMenuItem = "Labels"
    private static let AddLabelMenuItem = "Add Label"
    private static let KeyMenuItem = "Key"
    private static let SettingsMenuItem = "Settings"
    
    var TableArray  = [String]()
    
    override func viewDidLoad()
    {
        TableArray = [BackTableViewController.LabelsMenuItem, BackTableViewController.AddLabelMenuItem, BackTableViewController.KeyMenuItem, BackTableViewController.SettingsMenuItem]

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
     
        cell.backgroundColor = UIColor.clearColor()
        
        // Set color when cell is tapped
        let selectedBackgroundViewForCell = UIView()
        selectedBackgroundViewForCell.backgroundColor = DonoViewController.DarkPrimaryColor
        cell.selectedBackgroundView = selectedBackgroundViewForCell;
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        let destinationViewControllerId = self.getViewControllerFromMenu(self.TableArray[indexPath.row])
        let destinationViewController = (self.storyboard?.instantiateViewControllerWithIdentifier(destinationViewControllerId))! as UIViewController
        
        navigationController.pushViewController(destinationViewController, animated: true)
    }
    
    private func getViewControllerFromMenu(menuItem: String) -> String
    {
        if (menuItem == BackTableViewController.LabelsMenuItem)
        {
            return "LabelsViewController"
        }
        else if (menuItem == BackTableViewController.AddLabelMenuItem)
        {
            return "AddLabelViewController"
        }
        else if (menuItem == BackTableViewController.KeyMenuItem)
        {
            return "KeyViewController"
        }
        else if (menuItem == BackTableViewController.SettingsMenuItem)
        {
            return "SettingsViewController"
        }
        else
        {
            return String()
        }
    }
}