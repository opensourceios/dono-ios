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

import Foundation
import PasscodeLock
import SwiftKeychainWrapper

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
        return KeychainWrapper.objectForKey(PasscodeKey) as? [String] ?? nil
    }
    
    func savePasscode(passcode: [String])
    {
        KeychainWrapper.setObject(passcode, forKey: PasscodeKey)
    }
    
    func deletePasscode()
    {
        KeychainWrapper.removeObjectForKey(PasscodeKey)
    }
}
