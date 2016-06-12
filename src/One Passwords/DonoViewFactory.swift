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

import UIKit

class DonoViewFactory
{
    internal func makeFlexBarButton() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    }
    
    internal func makeKeyboardToolbarButton(image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem
    {
        let img = image.imageWithRenderingMode(.AlwaysOriginal)
        
        return UIBarButtonItem(image: img, style: .Plain, target: target, action: action)
    }

    internal func makeKeyboardToolbar() -> UIToolbar
    {
        let keyboardToolbar = UIToolbar()
        
        keyboardToolbar.sizeToFit()
        keyboardToolbar.translucent = false
        keyboardToolbar.backgroundColor = UIColor.clearColor()
        keyboardToolbar.barTintColor = DonoViewController.PrimaryColor

        return keyboardToolbar
    }
    
    internal func makeSearchController(resultsUpdater: UISearchResultsUpdating?) -> UISearchController
    {
        let controller = UISearchController(searchResultsController: nil)
        
        controller.searchResultsUpdater = resultsUpdater
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.translucent = false
        controller.searchBar.barTintColor = DonoViewController.PrimaryColor
        
        // White Cancel button
        (UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self])).tintColor = UIColor.whiteColor()
        
        // Remove the white line that appears after dragging the cells down
        controller.searchBar.layer.borderWidth = 1
        controller.searchBar.layer.borderColor = DonoViewController.PrimaryColor.CGColor
        
        controller.searchBar.placeholder = "Search your Labels"

        return controller
    }
}
