//
//  ViewController.swift
//  One Passwords
//
//  Created by Ghost on 2/17/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import UIKit

class LabelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating
{

    @IBOutlet weak var Open: UIBarButtonItem!
        
    @IBOutlet weak var serviceTagsTable: UITableView!
    
    var persistableKey = PersistableKey()
    var persistableServiceTags = PersistableServiceTags()
    var op = OnePasswords()
    
    // TableView Search
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.persistableServiceTags.getAll()
        self.setupTableView()
        
        self.Open.target = self.revealViewController()
        self.Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.persistableServiceTags.getAll()
        self.serviceTagsTable.reloadData()
    }
        
    internal func getPassword(serviceTag: String)
    {
        self.hideSearchAndKeyboard()
        
        let key = self.persistableKey.getKey()
        
        if (key.isEmpty)
        {
            showError("You haven't entered your Key!")
            return
        }
        
        let d = self.op.computePassword(key, st: serviceTag)
        copyToPasteboard(d)

        self.showAlert("Your password for " + serviceTag + " is ready to be pasted!")

        self.persistableServiceTags.add(serviceTag)
        self.serviceTagsTable.reloadData()
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
            return self.persistableServiceTags.count()
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
            let serviceTag = self.persistableServiceTags.getAt(indexPath.row)
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
        let array = (self.persistableServiceTags.getAll() as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.serviceTagsTable.reloadData()
    }
    
    // TableView Delete Action
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            self.persistableServiceTags.deleteAt(indexPath.row);
            self.serviceTagsTable.reloadData();
        })
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
    }
    
    // Helper Methods
    private func showAlert(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#2196f3")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.hideOnTap = true
        
        self.view.dodo.show(message);
    }

    private func showError(message: String)
    {
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#f44336")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.hideOnTap = true
        
        self.view.dodo.show(message);
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
            
            //self.serviceTagsTable.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.serviceTagsTable.reloadData()
    }
}
