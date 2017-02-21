//
//  DataStore.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    var outboundData = [String : String]()
    
    var profileData = [String : String]() {
        didSet {
            print("ProfileData Set: \(profileData)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLabel"), object: nil)
        }
    }
}
