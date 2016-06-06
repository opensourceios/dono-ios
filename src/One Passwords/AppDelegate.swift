//
//  AppDelegate.swift
//  One Passwords
//
//  Created by Ghost on 2/17/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import PasscodeLock
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    lazy var passcodeLockPresenter: PasscodeLockPresenter = {
        self.initializePasscodeLockPresenter()
    }()
    
    func initializePasscodeLockPresenter() -> PasscodeLockPresenter
    {
        let configuration = PasscodeLockConfiguration()
        let presenter = PasscodeLockPresenter(mainWindow: self.window, configuration: configuration)
        
        return presenter
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(passcodeFail(_:)), name: PasscodeLockIncorrectPasscodeNotification, object: nil)
        
        self.passcodeLockPresenter.presentPasscodeLock()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        passcodeLockPresenter.presentPasscodeLock()
    }
    
    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.        
    }
    
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func passcodeFail(notification: NSNotification)
    {
        // Destroy sensitive data
        PersistableKey().delete()
        PasscodeLockConfiguration().repository.deletePasscode()
        
        self.passcodeLockPresenter.dismissPasscodeLock()
    
        (self.window?.rootViewController as! DonoViewController).showError("Passcode was entered wrong 3 times. Your Key and your Passcode Pin were deleted")
        
        self.passcodeLockPresenter = self.initializePasscodeLockPresenter()
    }
}

