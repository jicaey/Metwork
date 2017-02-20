//
//  ProfileDetailViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    
    let profileDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.purple
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = Constants.Fonts.boldLarge
        button.addTarget(nil, action: #selector(doneButtonTouched), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(profileDetailView)
        view.addConstraints(withFormat: "H:|[v0]|", views: profileDetailView)
        view.addConstraints(withFormat: "V:|[v0]|", views: profileDetailView)
        
        view.addSubview(doneButton)
        view.addConstraints(withFormat: "H:[v0(50)]-18-|", views: doneButton)
        view.addConstraints(withFormat: "V:|-18-[v0]", views: doneButton)
        
    }
    
    func doneButtonTouched() {
        self.dismiss(animated: true, completion: nil)
    }
}
