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
        view.backgroundColor = Constants.Colors.purple
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = Constants.Fonts.boldLarge
        button.addTarget(nil, action: #selector(ProfileDetailViewController.doneButtonTouched), for: .touchUpInside)
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
        
        addSubview(doneButton)
        addConstraints(withFormat: "H:[v0(50)]-18-|", views: doneButton)
        addConstraints(withFormat: "V:|-18-[v0]", views: doneButton)
    }

}
