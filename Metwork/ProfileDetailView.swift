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
    
//    let doneButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Done", for: .normal)
//        button.titleLabel?.font = Constants.Fonts.boldLarge
//        button.addTarget(nil, action: #selector(ProfileDetailViewController.doneButtonTouched), for: .touchUpInside)
//        return button
//    }()
    
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
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = Constants.Fonts.boldLarge
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
        addConstraints(withFormat: "H:|-18-[v0(30)][v1]-36-|", views: profileNameImageView, profileNameTextField)
        addConstraints(withFormat: "V:|-36-[v0(30)]", views: profileNameTextField)
        addConstraints(withFormat: "V:|-36-[v0(30)]", views: profileNameImageView)
        
        addSubview(saveButton)
        addConstraints(withFormat: "H:|-50-[v0]-50-|", views: saveButton)
        addConstraints(withFormat: "V:[v0(30)]-36-|", views: saveButton)
//        addSubview(doneButton)
//        addConstraints(withFormat: "H:[v0(50)]-18-|", views: doneButton)
//        addConstraints(withFormat: "V:|-18-[v0]", views: doneButton)
        
    }

}
