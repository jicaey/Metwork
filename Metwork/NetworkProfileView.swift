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
        label.text = "Developer Networking Profile"
        label.font = Constants.Fonts.regMedium
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.Colors.purple
        
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
    }
}
