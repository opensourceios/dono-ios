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
import CGLMail

class ContactUsTableViewCell : UITableViewCell
{
    private static var Subject = "Hey Dono team!"
    
    // Emails in alphabetical order
    private static var DonoTeam =
        [
            "panos.sakkos@gmail.com",
            "stanko.krtalic@gmail.com",
            "vincento@posteo.net",
        ]
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        if (selected)
        {
            self.openMail()
        }
    }
    
    internal func openMail()
    {
        let vc = CGLMailHelper.mailViewControllerWithRecipients(
            ContactUsTableViewCell.DonoTeam,
            subject: ContactUsTableViewCell.Subject,
            message: String(),
            isHTML: false,
            includeAppInfo: false,
            completion: nil)
        
        if (vc != nil)
        {
            self.viewController()!.presentViewController(vc, animated: true, completion: nil)
        }
    }
}