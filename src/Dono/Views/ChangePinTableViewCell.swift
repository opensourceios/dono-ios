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

import UIKit
import PasscodeLock

class ChangePinTableViewCell : UITableViewCell
{
    override func setSelected(selected: Bool, animated: Bool)
    {
        if (selected)
        {
            let configuration = PasscodeLockConfiguration(repository: DonoViewController.PasscodeRepository)
            
            let passcodeLock = PasscodeLockViewController(state: .ChangePasscode, configuration: configuration)
            
            self.viewController()!.presentViewController(passcodeLock, animated: true, completion: nil)
        }
    }
    
    func hideWithAnimation()
    {
        UIView.animateWithDuration(0.3,
                                   animations: { self.alpha = 0 },
                                   completion: { (finished: Bool) -> () in self.hidden = finished })
    }
    
    func showWithAnimation()
    {
        UIView.animateWithDuration(0.3,
                                   animations: { self.alpha = 1 },
                                   completion: { (finished: Bool) -> () in self.hidden = !finished })
    }
}