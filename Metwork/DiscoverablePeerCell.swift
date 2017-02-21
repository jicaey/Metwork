//
//  DiscoverablePeerCell.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import Foundation
import UIKit

class DiscoverablePeerCell: BaseCell {

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholderPeerImage")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.grey
        return view
    }()
    
    let peerIdLabel: UILabel = {
        let label = UILabel()
        label.text = "Anthony Miller"
        label.font = Constants.Fonts.boldMedium
        return label
    }()
    
//    let statusLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Status: Available"
//        label.font = Constants.Fonts.italicSmall
//        return label
//    }()
    
    let professionLabel: UILabel = {
        let label = UILabel()
        label.text = "•  iOS Developer and stuff"
        label.font = Constants.Fonts.regSmall
        return label
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(peerIdLabel)
        addSubview(professionLabel)
        
        // horizontal
        addConstraints(withFormat: "H:|-16-[v0(44)]-8-[v1]-8-[v2]", views: thumbnailImageView, peerIdLabel, professionLabel)
        
        // vertical
        addConstraints(withFormat: "V:|-3-[v0]-3-|", views: thumbnailImageView)
        addConstraints(withFormat: "V:|-14-[v0(20)]|", views: peerIdLabel)
        addConstraints(withFormat: "V:|-15-[v0(20)]", views: professionLabel)
        
        // separator
        addConstraints(withFormat: "H:|[v0]|", views: separatorView)
        addConstraints(withFormat: "V:[v0(1)]|", views: separatorView)
    }
}
