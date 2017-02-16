//
//  Constants.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Colors {
        static let green = UIColor(red: 0.00, green: 0.73, blue: 0.33, alpha: 1.0)
        static let purple = UIColor(red: 0.24, green: 0.14, blue: 0.64, alpha: 1.0)
        static let pink = UIColor(red: 1.00, green: 0.00, blue: 0.58, alpha: 1.0)
        static let blue = UIColor(red: 0.00, green: 0.71, blue: 0.97, alpha: 1.0)
        static let yellow = UIColor(red: 0.98, green: 0.97, blue: 0.00, alpha: 1.0)
        static let grey = UIColor(red: 0.9294, green: 0.9294, blue: 0.9294, alpha: 1.0)
    }
    
    struct FontSizes {
        static let large = CGFloat(20)
        static let medium = CGFloat(16)
        static let small = CGFloat(14)
    }
    
    struct Fonts {
        static let regLarge = UIFont(name: "Avenir Next Condensed", size: 20)
        static let regMedium = UIFont(name: "Avenir Next Condensed", size: 16)
        static let regSmall = UIFont(name: "Avenir Next Condensed", size: 14)
        static let italicSmall = UIFont(name: "AvenirNextCondensed-Italic", size: 14)
        static let title = UIFont(name: "AvenirNextCondensed-Medium", size: 24)
    }
    
    struct CellIdentifiers {
        static let discoverablePeer = "discoverablePeerCellID"
        static let networkHistory = "networkHistory"
        static let chatTableViewCell = "chatCell"
    }
    
    struct MPC {
        // must be < 15 characters, contain only lowercase ASCII characters, numbers, hyphens
        static let serviceType = "metwork-mpc"
        static let segueChatIdentifier = "idSegueChat"
    }
    
    struct NotificationCenterNames {
        static let advertiseToggleSwitch = Notification(name: Notification.Name(rawValue: "advertiseToggleNotification"))
    }
}
