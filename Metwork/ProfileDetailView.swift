//
//  ProfileDetailView.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class ProfileDetailView: UIView {
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.blue
        return view
    }()
    
    let profileNameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Display Name"
        return textField
    }()
    
    let profileNameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "eMail Address"
        return textField
    }()
    
    let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "email")
        return imageView
    }()
    
    let websiteTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Website URL"
        return textField
    }()
    
    let websiteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "website")
        return imageView
    }()
    
    let githubTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Github Link"
        return textField
    }()
    
    let githubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        return imageView
    }()
    
    let linkedinTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Linkedin Profile Link"
        return textField
    }()
    
    let linkedinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "linkedin")
        return imageView
    }()
    
    let facebookTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Facebook Profile Link"
        return textField
    }()
    
    let facebookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "facebook")
        return imageView
    }()
    
    let twitterTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = Constants.Fonts.regMedium
        textField.placeholder = "Twitter Profile Link"
        return textField
    }()
    
    let twitterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "twitter")
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = Constants.Fonts.boldLarge
        button.addTarget(nil, action: #selector(ProfileDetailViewController.saveButtonTouched), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(backgroundView)
        addConstraints(withFormat: "H:|[v0]|", views: backgroundView)
        addConstraints(withFormat: "V:|[v0]|", views: backgroundView)
        
        addSubview(profileNameTextField)
        addSubview(profileNameImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: profileNameImageView, profileNameTextField)
        addConstraints(withFormat: "V:|-36-[v0(30)]", views: profileNameTextField)
        addConstraints(withFormat: "V:|-36-[v0(30)]", views: profileNameImageView)
        
        addSubview(emailTextField)
        addSubview(emailImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: emailImageView, emailTextField)
        addConstraints(withFormat: "V:|-74-[v0(30)]", views: emailTextField)
        addConstraints(withFormat: "V:|-74-[v0(30)]", views: emailImageView)
        
        addSubview(websiteTextField)
        addSubview(websiteImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: websiteImageView, websiteTextField)
        addConstraints(withFormat: "V:|-112-[v0(30)]", views: websiteTextField)
        addConstraints(withFormat: "V:|-112-[v0(30)]", views: websiteImageView)
        
        addSubview(githubTextField)
        addSubview(githubImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: githubImageView, githubTextField)
        addConstraints(withFormat: "V:|-150-[v0(30)]", views: githubTextField)
        addConstraints(withFormat: "V:|-150-[v0(30)]", views: githubImageView)
        
        addSubview(linkedinTextField)
        addSubview(linkedinImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: linkedinImageView, linkedinTextField)
        addConstraints(withFormat: "V:|-188-[v0(30)]", views: linkedinTextField)
        addConstraints(withFormat: "V:|-188-[v0(30)]", views: linkedinImageView)
        
        addSubview(facebookTextField)
        addSubview(facebookImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: facebookImageView, facebookTextField)
        addConstraints(withFormat: "V:|-226-[v0(30)]", views: facebookTextField)
        addConstraints(withFormat: "V:|-226-[v0(30)]", views: facebookImageView)
        
        addSubview(twitterTextField)
        addSubview(twitterImageView)
        addConstraints(withFormat: "H:|-18-[v0(30)]-8-[v1]-36-|", views: twitterImageView, twitterTextField)
        addConstraints(withFormat: "V:|-264-[v0(30)]", views: twitterTextField)
        addConstraints(withFormat: "V:|-264-[v0(30)]", views: twitterImageView)
        
        
        addSubview(saveButton)
        addConstraints(withFormat: "H:|-50-[v0]-50-|", views: saveButton)
        addConstraints(withFormat: "V:[v0(30)]-36-|", views: saveButton)
    }

}
