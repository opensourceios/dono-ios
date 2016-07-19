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