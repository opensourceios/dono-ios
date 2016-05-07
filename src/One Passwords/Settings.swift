//
//  Settings.swift
//  Dono
//
//  Created by Ghost on 5/7/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation

class Settings
{
    var REMEMBER_KEY_KEY = "rememberKey"
    var PASSCODE_LOCK_KEY = "passcodeLockKey"
    
    func getRememberKeyValue() -> Bool
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(REMEMBER_KEY_KEY)
    }
    
    func setRememberKeyValue(value: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(value, forKey: REMEMBER_KEY_KEY)
    }
    
    func getPasscodeLockValue() -> Bool
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(PASSCODE_LOCK_KEY)
    }
    
    func setPasscodeLockValue(value: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(value, forKey: PASSCODE_LOCK_KEY)
    }
}