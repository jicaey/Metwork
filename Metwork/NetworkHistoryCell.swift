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
        bg.backgroundColor = Constants.Colors.green
//        bg.layer.shadowColor = UIColor.black.cgColor
//        bg.layer.shadowOpacity = 1
//        bg.layer.shadowOffset = CGSize(width: -1, height: 0)
//        bg.layer.shadowRadius = 5
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
        label.textColor = .white
        
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
