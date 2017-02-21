//
//  ProfileDetailViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    let store = DataStore.sharedInstance
    let profileDetailView = ProfileDetailView()
    let networkProfileView = NetworkProfileView()
    
        
    override func viewDidLoad() {
        setupViews()
        profileDetailView.profileNameTextField.delegate = self
    }
    
    func setupViews() {
        view.addSubview(profileDetailView)
        view.addConstraints(withFormat: "H:|[v0]|", views: profileDetailView)
        view.addConstraints(withFormat: "V:|[v0]|", views: profileDetailView)
    }
    
    func saveButtonTouched() {
        let displayNameInput = profileDetailView.profileNameTextField.text
        store.profileData["displayName"] = displayNameInput
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButtonTouched()
    }
}
