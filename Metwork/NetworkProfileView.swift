//
//  NetworkProfileView.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class NetworkProfileView: UIView {
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = Constants.Colors.blue
        return view
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Advertise Networking Profile?"
        label.textColor = .white
        label.font = Constants.Fonts.regLarge
        return label
    }()
    
    let advertiseToggleButton: UISwitch = {
        let button = UISwitch()
        button.isOn = true
        button.setOn(true, animated: false)
        button.onTintColor = Constants.Colors.pink
        button.addTarget(nil, action: #selector(MainViewController.adversiseToggleDidChange(sender:)), for: .valueChanged)
        return button
    }()
    
    let tempButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.pink
        button.addTarget(nil, action: #selector(MainViewController.handleTempButtonTouch), for: .touchUpInside)
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
        addSubview(cardView)
        addConstraints(withFormat: "H:|-20-[v0]-20-|", views: cardView)
        addConstraints(withFormat: "V:|-20-[v0]-20-|", views: cardView)
        
        addSubview(profileNameLabel)
        addConstraints(withFormat: "H:|-36-[v0]", views: profileNameLabel)
        addConstraints(withFormat: "V:|-36-[v0(20)]", views: profileNameLabel)
        
        addSubview(advertiseToggleButton)
        addConstraints(withFormat: "H:[v0]-36-|", views: advertiseToggleButton)
        addConstraints(withFormat: "V:|-30-[v0]", views: advertiseToggleButton)
        
        addSubview(tempButton)
        addConstraints(withFormat: "H:|-150-[v0(100)]", views: tempButton)
        addConstraints(withFormat: "V:|-70-[v0(20)]", views: tempButton)
        
        backgroundColor = Constants.Colors.purple
    }
}
