//
//  Dono
//
//  Created by Ghost on 5/24/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Dodo
import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#2196f3")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
    
    func showError(message: String) {
        
        self.view.dodo.topLayoutGuide = self.topLayoutGuide
        self.view.dodo.style.label.color = UIColor.whiteColor()
        self.view.dodo.style.bar.backgroundColor = DodoColor.fromHexString("#f44336")
        self.view.dodo.style.bar.hideAfterDelaySeconds = 5
        self.view.dodo.style.bar.hideOnTap = true
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.show(message)
    }
}