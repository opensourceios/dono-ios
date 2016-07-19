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
import Foundation
import PasscodeLock
import SWRevealViewController

class SettingsViewController : DonoTableViewController
{
    @IBOutlet weak var passcodeLock: UISwitch!
    
    @IBOutlet weak var rememberKey: UISwitch!
    
    let configuration: PasscodeLockConfigurationType
    
    var settings = Settings()

    init(configuration: PasscodeLockConfigurationType)
    {
        self.configuration = configuration
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        let repository = UserDefaultsPasscodeRepository()
        configuration = PasscodeLockConfiguration(repository: repository)
        
        super.init(coder: aDecoder)
    }
        
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.updateViewWithSettings()
    }
    
    @IBAction func passcodeLockValueChanged(sender: AnyObject)
    {
        let passcodeVC: PasscodeLockViewController
        
        if (self.passcodeLock.on)
        {
            passcodeVC = PasscodeLockViewController(state: .SetPasscode, configuration: configuration)
            
            passcodeVC.successCallback = { lock in
                
                self.updateViewWithSettings()
            }
        }
        else
        {
            passcodeVC = PasscodeLockViewController(state: .RemovePasscode, configuration: configuration)
            
            passcodeVC.successCallback = { lock in
                
                lock.repository.deletePasscode()
                
                self.updateViewWithSettings()
            }
        }
        
        presentViewController(passcodeVC, animated: true, completion: { self.updateViewWithSettings() } )
    }

    @IBAction func rememberKeyValueChanged(sender: AnyObject)
    {
        self.settings.setRememberKeyValue(self.rememberKey.on)

        let key = PersistableKey()

        if (self.rememberKey.on)
        {
            key.save()
        }
        else
        {
            key.delete()
        }
    }
    
    private func updateViewWithSettings()
    {
        self.rememberKey.on = self.settings.getRememberKeyValue()
        self.passcodeLock.on = self.configuration.repository.hasPasscode
    }
}