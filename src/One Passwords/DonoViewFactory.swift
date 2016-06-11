//
//  ViewFactory.swift
//  Dono
//
//  Created by Ghost on 6/11/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import UIKit

class DonoViewFactory
{
    internal func makeKeyboardToolbar() -> UIToolbar
    {
        let keyboardToolbar = UIToolbar()
        
        keyboardToolbar.sizeToFit()
        keyboardToolbar.translucent = false
        keyboardToolbar.backgroundColor = UIColor.clearColor()
        keyboardToolbar.barTintColor = DonoViewController.PrimaryColor

        return keyboardToolbar
    }
    
    internal func makeFlexBarButton() -> UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    }
    
    internal func makeKeyboardToolbarButton(var image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem
    {
        image = image.imageWithRenderingMode(.AlwaysOriginal)
        
        return UIBarButtonItem(image: image, style: .Plain, target: target, action: action)
    }
}
