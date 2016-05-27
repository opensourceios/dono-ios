//
//  PersistableKey.swift
//  One Passwords
//
//  Created by Ghost on 3/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

internal class PersistableKey
{
    static var Key = String();
    static var KeyKeychainKey = "dono.key"
    
    internal func getKey() -> String
    {
        if (!PersistableKey.Key.isEmpty)
        {
            return PersistableKey.Key;
        }
        else
        {
            loadKey();
            
            return PersistableKey.Key;
        }
    }
    
    internal func setkey(key: String, remember: Bool)
    {
        PersistableKey.Key = key;
            
        if (remember)
        {
            saveKey();
        }
    }
    
    internal func delete()
    {
        PersistableKey.Key = String()
        KeychainWrapper.removeObjectForKey(PersistableKey.KeyKeychainKey)
    }
    
    internal func save()
    {
        self.saveKey()
    }
    
    private func loadKey()
    {
        let retrievedString: String? = KeychainWrapper.stringForKey(PersistableKey.KeyKeychainKey)
        
        if (retrievedString != nil)
        {
            PersistableKey.Key = retrievedString!
        }
    }
    
    private func saveKey()
    {
        KeychainWrapper.setString(PersistableKey.Key, forKey: PersistableKey.KeyKeychainKey)
    }
}