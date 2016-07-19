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
import DonoCore
import MCSwipeTableViewCell
import SWRevealViewController
import UIKit

class LabelsViewController: DonoViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var lonelyLabel: UITableView!
    
    @IBOutlet weak var labelsTableView: UITableView!
    
    var dono = Dono()
    
    // TableView Search
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableLabels.getAll()
        
        self.setupTableView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.updateTableView()
    }
        
    internal func getPassword(label: String)
    {
        self.hideSearchAndKeyboard()
        
        let key = self.persistableKey.getKey()
        
        if (key.isEmpty)
        {
            showError("You need to set your Key in order to derive passwords for your Labels!")

            self.labelsTableView.reloadData()
            
            return
        }
        
        let d = self.dono.computePassword(key, l: label)

        copyToPasteboard(d!)

        self.showAlert("Your password for " + label + " is ready to be pasted!")

        self.labelsTableView.reloadData()
    }
        
    // TableView data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.resultSearchController.active)
        {
            return self.filteredTableData.count
        }
        else
        {
            return self.persistableLabels.count()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("Label Cell", forIndexPath: indexPath) as? MCSwipeTableViewCell

        if (cell == nil)
        {
            cell = MCSwipeTableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        // setup
        cell!.separatorInset = UIEdgeInsetsZero
        cell!.layoutMargins = UIEdgeInsetsZero
        cell!.defaultColor = DonoViewController.PrimaryColor
        cell!.firstTrigger = 0.2;

        cell!.setSwipeGestureWithView(UIImageView(image: DonoViewController.DeleteSweepImage!), color: DonoViewController.Red, mode: .Exit, state: .State3, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in

            self.persistableLabels.deleteAt(indexPath.row);

            self.updateTableView()
        })
        
        if (self.resultSearchController.active)
        {
            cell!.textLabel?.text = filteredTableData[indexPath.row]
        }
        else
        {
            let serviceTag = self.persistableLabels.getAt(indexPath.row)
            cell!.textLabel?.text = serviceTag
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let serviceTagCell = tableView.cellForRowAtIndexPath(indexPath)
        
        self.getPassword((serviceTagCell!.textLabel?.text)!)
    }
    
    // TableView Search
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.persistableLabels.getAll() as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.labelsTableView.reloadData()
    }

    private func updateTableView()
    {
        self.persistableLabels.getAll()
        self.labelsTableView.reloadData()
        self.handleLonelyLabel()
    }
    
    private func hideSearchAndKeyboard()
    {
        self.resultSearchController.active = false
        self.view.endEditing(true)
    }

    private func setupTableView()
    {
        self.resultSearchController =
        ({
            let controller = self.donoViewFactory.makeSearchController(self)
            self.labelsTableView.tableHeaderView = controller.searchBar

            return controller
        })()

        self.updateTableView()
    }
    
    private func handleLonelyLabel()
    {
        self.persistableLabels.getAll()

        if (self.persistableLabels.count() > 0)
        {
            self.lonelyLabel.hidden = true
        }
        else
        {
            self.lonelyLabel.hidden = false
        }

        self.labelsTableView.hidden = !self.lonelyLabel.hidden
    }
}
