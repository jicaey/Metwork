//
//  NetworkHistoryCell.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class NetworkHistoryCell: BaseCell {
    let backgroundCell: UIView = {
        let bg = UIView()
        bg.layer.cornerRadius = 5
        bg.backgroundColor = Constants.Colors.pink
        return bg
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 3
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "JamieCampbellBower")
        return iv
    }()
    
    let peerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jamie Campbell Bower"
        label.font = Constants.Fonts.regSmall
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(backgroundCell)
        addConstraints(withFormat: "H:|-8-[v0]-8-|", views: backgroundCell)
        addConstraints(withFormat: "V:|-8-[v0]-8-|", views: backgroundCell)
        
        addSubview(imageView)
        addConstraints(withFormat: "H:|-16-[v0(30)]", views: imageView)
        addConstraints(withFormat: "V:[v0(30)]-16-|", views: imageView)
        
        addSubview(peerNameLabel)
        addConstraints(withFormat: "H:|-16-[v0]-16-|", views: peerNameLabel)
        addConstraints(withFormat: "V:|-16-[v0(20)]", views: peerNameLabel)
        
        backgroundColor = Constants.Colors.purple
    }
}
