//
//  ProfileDetailViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit
import CoreData

class ProfileDetailViewController: UIViewController {
    let store = DataStore.sharedInstance
    let profileDetailView = ProfileDetailView()
    let networkProfileView = NetworkProfileView()
    
    
    override func viewDidLoad() {
        setupViews()
        updateTextFields()
        
        profileDetailView.profileNameTextField.delegate = self
        
        store.fetchProfileData()
    }
    
    func setupViews() {
        view.addSubview(profileDetailView)
        view.addConstraints(withFormat: "H:|[v0]|", views: profileDetailView)
        view.addConstraints(withFormat: "V:|[v0]|", views: profileDetailView)
    }
    
    func saveButtonTouched() {
        
        let displayNameInput = profileDetailView.profileNameTextField.text
        
        let emailInput = profileDetailView.emailTextField.text
        let websiteInput = profileDetailView.websiteTextField.text
        let githubInput = profileDetailView.githubTextField.text
        let linkedinInput = profileDetailView.linkedinTextField.text
        let facebookInput = profileDetailView.facebookTextField.text
        let twitterInput = profileDetailView.twitterTextField.text
        
        store.profileInput["displayName"] = displayNameInput
        
        store.profileInput["email"] = emailInput
        store.profileInput["website"] = websiteInput
        store.profileInput["github"] = githubInput
        store.profileInput["linkedin"] = linkedinInput
        store.profileInput["facebook"] = facebookInput
        store.profileInput["twitter"] = twitterInput
        
        store.saveProfileData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateTextFields() {
        let profileInput = store.profileInput
        
        for (key, value) in profileInput {
            switch key {
            case "displayName":
                profileDetailView.profileNameTextField.text = value
            case "email":
                profileDetailView.emailTextField.text = value
            case "website":
                profileDetailView.websiteTextField.text = value
            case "github":
                profileDetailView.githubTextField.text = value
            case "linkedin":
                profileDetailView.linkedinTextField.text = value
            case "facebook":
                profileDetailView.facebookTextField.text = value
            case "twitter":
                profileDetailView.twitterTextField.text = value
            default: break
            }
        }
    }
}

extension ProfileDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        saveButtonTouched()
    }
}
