//
//  ChatTableViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/15/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let store = DataStore.sharedInstance
    
    var messagesArray = [[String : String]]()
    var receivedData = [String : String]()
    let chatView = ChatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.chatTableView.delegate = self
        chatView.chatTableView.dataSource = self
        chatView.chatTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedData), name: Constants.MPC.receivedDataNotification, object: nil)
        
        setupViews()
    }

    func setupViews() {
        view.addSubview(chatView)
        view.addConstraints(withFormat: "H:|[v0]|", views: chatView)
        view.addConstraints(withFormat: "V:|[v0]|", views: chatView)
    }
    
    // MARK: TODO - Fix names, unwrap
    func handleMPCReceivedData(withNotification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = withNotification.object as! [String : AnyObject]
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? Data
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
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
            } else {
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
        
        if dataDictionary["displayName"] != nil {
            print("*****Receieved Data*****")
            receivedData = dataDictionary
            // TODO: Move
            OperationQueue.main.addOperation({ () -> Void in
                self.chatView.testTextView.text = "\(self.receivedData)"
            })
            
        } else {
            OperationQueue.main.addOperation({ () -> Void in
                self.chatView.testTextView.text = "Couldn't find displayName"
            })
            
        }
        
    }
    
    func handleEndChatButtonTouch() {
        let messageDictionary = ["message": "_end_chat_"]
        let connectedPeers = appDelegate.mpcManager.session.connectedPeers
        
        if connectedPeers.count > 0 {
            if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: connectedPeers[0] as MCPeerID) {
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
        chatView.chatTableView.reloadData()
        
        if chatView.chatTableView.contentSize.height > chatView.chatTableView.frame.size.height {
            let indexPath = IndexPath(row: messagesArray.count - 1, section: 0)
            chatView.chatTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    
    // TODO: Add encryption
    func sendDataButtonTouched() {
        let outboundData = store.outboundData
        let peer = appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: outboundData, toPeer: peer) {
            print("Data Sent")
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    // MARK: TODO - unwrap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let messageDictionary: [String: String] = ["message": textField.text!]
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
