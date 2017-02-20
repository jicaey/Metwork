//
//  ChatView.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class ChatView: UIView {

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    // MARK: TODO - Limit character count and fix constraints
    let chatTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Constants.Colors.blue
        textField.font = Constants.Fonts.regSmall
        textField.sizeToFit()
        textField.isUserInteractionEnabled = true
        textField.text = "Placeholder"
        textField.layoutIfNeeded()
        return textField
    }()
    
    let chatSendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = Constants.Fonts.regMedium
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let endChatButton: UIButton = {
        let button = UIButton()
        button.setTitle("End Chat", for: .normal)
        button.titleLabel?.font = Constants.Fonts.regMedium
        button.titleLabel?.textColor = .white
        button.addTarget(nil, action: #selector(ChatViewController.handleEndChatButtonTouch), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.chatTableViewCell)
        
//        chatTableView.delegate = ChatViewController()
//        chatTableView.dataSource = ChatViewController()
//        
//        chatTextField.delegate = ChatViewController()
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(backgroundView)
        addConstraints(withFormat: "H:|[v0]|", views: backgroundView)
        addConstraints(withFormat: "V:|[v0]|", views: backgroundView)
        
        addSubview(chatTableView)
        addConstraints(withFormat: "H:|[v0]|", views: chatTableView)
        addConstraints(withFormat: "V:|-200-[v0]|", views: chatTableView)
        
        addSubview(chatTextField)
        addConstraints(withFormat: "H:|[v0]-50-|", views: chatTextField)
        addConstraints(withFormat: "V:|-150-[v0]", views: chatTextField)
        
        addSubview(chatSendButton)
        addConstraints(withFormat: "H:[v0(50)]|", views: chatSendButton)
        addConstraints(withFormat: "V:|-150-[v0]", views: chatSendButton)
        
        addSubview(endChatButton)
        addConstraints(withFormat: "H:[v0]|", views: endChatButton)
        addConstraints(withFormat: "V:|-16-[v0]", views: endChatButton)
    }
}
