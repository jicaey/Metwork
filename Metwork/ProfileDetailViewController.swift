//
//  ProfileDetailViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    let profileDetailView = ProfileDetailView()
        
    override func viewDidLoad() {
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(profileDetailView)
        view.addConstraints(withFormat: "H:|[v0]|", views: profileDetailView)
        view.addConstraints(withFormat: "V:|[v0]|", views: profileDetailView)
    }
    
    func doneButtonTouched() {
        self.dismiss(animated: true, completion: nil)
    }
}
