//
//  ChatTableViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/15/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit
import MultipeerConnectivity

// MARK: TODO - Refactor MVC
class ChatViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var messagesArray = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.green
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedData), name: Constants.MPC.receivedDataNotification, object: nil)
        
        setupViews()
    }
    
    let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.purple
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
        button.addTarget(nil, action: #selector(handleEndChatButtonTouch), for: .touchUpInside)
        return button
    }()
    
    func setupViews() {
        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.chatTableViewCell)
        
        view.addSubview(chatView)
        view.addConstraints(withFormat: "H:|[v0]|", views: chatView)
        view.addConstraints(withFormat: "V:|[v0(200)]", views: chatView)
        
        view.addSubview(chatTableView)
        view.addConstraints(withFormat: "H:|[v0]|", views: chatTableView)
        view.addConstraints(withFormat: "V:|-200-[v0]|", views: chatTableView)
        
        view.addSubview(chatTextField)
        view.addConstraints(withFormat: "H:|[v0]-50-|", views: chatTextField)
        view.addConstraints(withFormat: "V:|-150-[v0]", views: chatTextField)
        
        view.addSubview(chatSendButton)
        view.addConstraints(withFormat: "H:[v0(50)]|", views: chatSendButton)
        view.addConstraints(withFormat: "V:|-150-[v0]", views: chatSendButton)
        
        view.addSubview(endChatButton)
        view.addConstraints(withFormat: "H:[v0]|", views: endChatButton)
        view.addConstraints(withFormat: "V:|-16-[v0]", views: endChatButton)
    }
    
    // MARK: TODO - Fix names, unwrap
    func handleMPCReceivedData(withNotification: NSNotification) {
        print("************************* Entered handleMPCReceivedData()")
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = withNotification.object as! [String : AnyObject]
        print("receivedDataDictionary:\(receivedDataDictionary)")
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? Data
        print("data: \(data)")
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        print("fromPeer: \(fromPeer)")
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [String : String]
        print("dataDictionary: \(dataDictionary)")
        // Check if there's an entry with the "message" key.
        if let message = dataDictionary["message"] {
            // Make sure that the message is other than "_end_chat_".
            if message != "_end_chat_"{
                // Create a new dictionary and set the sender and the received message to it.
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                
                // Add this dictionary to the messagesArray array.
                messagesArray.append(messageDictionary)
                
                // Reload the tableview data and scroll to the bottom using the main thread.
                OperationQueue.main.addOperation({ () -> Void in
                    self.updateTableView()
                })
            }
            else{
                // In this case an "_end_chat_" message was received.
                // Show an alert view to the user.
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: UIAlertControllerStyle.alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    self.appDelegate.mpcManager.session.disconnect()
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(doneAction)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
    }
    
    // MARK: TODO - Refactor and unwrap
    func handleEndChatButtonTouch() {
        let messageDictionary = ["message": "_end_chat_"]
        if appDelegate.mpcManager.session.connectedPeers.count > 0 {
            if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID) {
                self.dismiss(animated: true, completion: { () -> Void in
                    self.appDelegate.mpcManager.session.disconnect()
                })
            }
        } else {
            self.dismiss(animated: true, completion: { () -> Void in
                self.appDelegate.mpcManager.session.disconnect()
            })
        }
    }
    
    func updateTableView() {
        print("entered updateTableView()")
        self.chatTableView.reloadData()
        
        if self.chatTableView.contentSize.height > self.chatTableView.frame.size.height {
            let indexPath = IndexPath(row: messagesArray.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    // MARK: TODO - unwrap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("****** entered textFieldShouldReturn()")
        textField.resignFirstResponder()
        
        let messageDictionary: [String: String] = ["message": textField.text!]
        print("MessageDictionary: \(messageDictionary)")
        let peer = appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: peer) {
            let dictionary: [String: String] = ["sender": "self", "message": textField.text!]
            messagesArray.append(dictionary)
            
            self.updateTableView()
        } else {
            print("Could not send data")
        }
        textField.text = ""
        return true
    }
}

extension ChatViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.chatTableViewCell, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.CellIdentifiers.chatTableViewCell)
        cell.detailTextLabel?.style
        let currentMessage = messagesArray[indexPath.row] as [String : String]
        
        if let sender = currentMessage["sender"] {
            var senderLabelText: String
            var senderColor: UIColor
            
            if sender == "self" {
                senderLabelText = "I said:"
                senderColor = Constants.Colors.blue
            } else {
                senderLabelText = sender + " said:"
                senderColor = Constants.Colors.green
            }
            cell.detailTextLabel?.text = senderLabelText
            cell.detailTextLabel?.textColor = senderColor
        }
        if let message = currentMessage["message"] {
            cell.textLabel?.text = message
        }
        return cell
    }
}
