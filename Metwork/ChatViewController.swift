//
//  ChatTableViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/15/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

// MARK: TODO - Refactor MVC
class ChatViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var messagesArray = [[String : String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.green
        
        setupViews()
    }
    
    let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.purple
        return view
    }()
    
    let chatTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: TODO - Limit character count
    let chatTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Constants.Colors.blue
        textView.font = Constants.Fonts.regSmall
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.isUserInteractionEnabled = true
        textView.text = "Placeholder"
        textView.layoutIfNeeded()
        return textView
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
        button.addTarget(nil, action: #selector(handleEndChatButtonTouch), for: .touchUpInside)
        return button
    }()
    
    func setupViews() {
        view.addSubview(chatView)
        view.addConstraints(withFormat: "H:|[v0]|", views: chatView)
        view.addConstraints(withFormat: "V:|[v0(200)]", views: chatView)
        
        view.addSubview(chatTableView)
        view.addConstraints(withFormat: "H:|[v0]|", views: chatTableView)
        view.addConstraints(withFormat: "V:|-200-[v0]|", views: chatTableView)
        
        view.addSubview(chatTextView)
        view.addConstraints(withFormat: "H:|[v0]-50-|", views: chatTextView)
        view.addConstraints(withFormat: "V:|-150-[v0]", views: chatTextView)
        
        view.addSubview(chatSendButton)
        view.addConstraints(withFormat: "H:[v0(50)]|", views: chatSendButton)
        view.addConstraints(withFormat: "V:|-150-[v0]", views: chatSendButton)
        
        view.addSubview(endChatButton)
        view.addConstraints(withFormat: "H:[v0]|", views: endChatButton)
        view.addConstraints(withFormat: "V:|-16-[v0]", views: endChatButton)
    }
    
    func handleEndChatButtonTouch() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ChatViewController: UITextViewDelegate {
}
