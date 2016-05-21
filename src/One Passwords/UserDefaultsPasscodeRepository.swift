//
//  UserDefaultsPasscodeRepository.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/29/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import PasscodeLock

class UserDefaultsPasscodeRepository: PasscodeRepositoryType
{
    private let PasscodeKey = "dono.passcode"
    
    var hasPasscode: Bool
    {
        if (passcode != nil)
        {
            return true
        }
        
        return false
    }
    
    var passcode: [String]?
    {
        return KeychainWrapper.standardKeychainAccess().objectForKey(PasscodeKey) as? [String] ?? nil
    }
    
    func savePasscode(passcode: [String])
    {
        KeychainWrapper.standardKeychainAccess().setObject(passcode, forKey: PasscodeKey)
    }
    
    func deletePasscode()
    {
        KeychainWrapper.standardKeychainAccess().removeObjectForKey(PasscodeKey)
    }
}
