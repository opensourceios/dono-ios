//
//  BackTableVC.swift
//  Dono
//
//  Created by Ghost on 5/6/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import Foundation

class BackTableVC : UITableViewController
{
    var TableArray  = [String]()
    
    override func viewDidLoad()
    {
        TableArray = ["Labels", "Add Label", "Key", "Settings"]

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
        selectedBackgroundViewForCell.backgroundColor = DodoColor.fromHexString("#1976d2")
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
    
    func getViewControllerFromMenu(menuItem: String) -> String
    {
        if (menuItem == "Labels")
        {
            return "LabelsViewController"
        }
        else if (menuItem == "Add Label")
        {
            return "AddLabelViewController"
        }
        else if (menuItem == "Key")
        {
            return "KeyViewController"
        }
        else if (menuItem == "Settings")
        {
            return "SettingsViewController"
        }
        else
        {
            return ""
        }
    }
}