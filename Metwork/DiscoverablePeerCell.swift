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
        label.font = Constants.Fonts.regMedium
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status: Available"
        label.font = Constants.Fonts.italicSmall
        return label
    }()
    
    let professionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer and stuff"
        label.font = Constants.Fonts.regSmall
        return label
    }()
    
    let connectChatButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "peerChat")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = Constants.Colors.green
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    let peerSendButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "peerSend")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = Constants.Colors.green
        button.setImage(buttonImage, for: .normal)
        //        button.isHidden = true
        return button
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(peerIdLabel)
        addSubview(statusLabel)
        addSubview(professionLabel)
        addSubview(connectChatButton)
        addSubview(peerSendButton)
        
        // horizontal
        addConstraints(withFormat: "H:|-16-[v0(44)]-8-[v1]-8-[v2]-8-[v3(44)][v4(44)]|", views: thumbnailImageView, peerIdLabel, professionLabel, peerSendButton, connectChatButton)
        addConstraints(withFormat: "H:|-76-[v0(200)]", views: statusLabel)
        
        
        // vertical
        addConstraints(withFormat: "V:|-3-[v0]-3-|", views: thumbnailImageView)
        addConstraints(withFormat: "V:|-3-[v0(20)]-4-[v1(20)]-3-|", views: statusLabel, peerIdLabel)
        addConstraints(withFormat: "V:|-27-[v0(20)]", views: professionLabel)
        addConstraints(withFormat: "V:|-3-[v0]-3-|", views: connectChatButton)
        addConstraints(withFormat: "V:|-3-[v0]-3-|", views: peerSendButton)
        
        // separator
        addConstraints(withFormat: "H:|[v0]|", views: separatorView)
        addConstraints(withFormat: "V:[v0(1)]|", views: separatorView)
    }
}
