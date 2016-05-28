//
//  ViewController.swift
//  One Passwords
//
//  Created by Ghost on 2/17/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import DonoCore
import SWRevealViewController
import UIKit

class LabelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var Open: UIBarButtonItem!
        
    @IBOutlet weak var lonelyLabel: UITableView!
    
    @IBOutlet weak var labelsTableView: UITableView!
    
    var persistableKey = PersistableKey()
    var persistableLabels = PersistableLabels()
    var dono = Dono()
    
    // TableView Search
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.persistableLabels.getAll()
        self.setupTableView()
        
        //RevealVC Boilerplate
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Setup swipe right gesture to open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.persistableLabels.getAll()
        self.labelsTableView.reloadData()
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

        copyToPasteboard(d)

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
        let cell = tableView.dequeueReusableCellWithIdentifier("Service Tag Cell", forIndexPath: indexPath);
        
        if (self.resultSearchController.active)
        {
            cell.textLabel?.text = filteredTableData[indexPath.row]
        }
        else
        {
            let serviceTag = self.persistableLabels.getAt(indexPath.row)
            cell.textLabel?.text = serviceTag
        }
        
        return cell
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
    
    // TableView Delete Action
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            self.persistableLabels.deleteAt(indexPath.row);
            self.labelsTableView.reloadData();
            self.handleLonelyLabel()
        })
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
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
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.translucent = true;
            controller.searchBar.barTintColor = DodoColor.fromHexString("#2196f3")
            // White Cancel button
            (UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self])).tintColor = UIColor.whiteColor()
            
            // Remove the white line that appears after dragging the cells down
            controller.searchBar.layer.borderWidth = 1
            controller.searchBar.layer.borderColor = DodoColor.fromHexString("#2196f3").CGColor
            
            self.labelsTableView.tableHeaderView = controller.searchBar
            
            // Remove black line from Navigation Bar
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            
            return controller
        })()
        
        self.labelsTableView.reloadData()
        self.handleLonelyLabel()
    }
    
    private func handleLonelyLabel()
    {
        self.persistableLabels.getAll()
        if (self.persistableLabels.count() == 0)
        {
            self.lonelyLabel.hidden = false
            self.labelsTableView.hidden = true
        }
        else
        {
            self.lonelyLabel.hidden = true
            self.labelsTableView.hidden = false
        }
    }
}
