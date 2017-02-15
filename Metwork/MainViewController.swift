//
//  MainViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class MainViewController: UICollectionViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let networkHistoryView: NetworkHistoryView = {
        let nb = NetworkHistoryView()
        return nb
    }()

    let networkProfileView: NetworkProfileView = {
        let np = NetworkProfileView()
        return np
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Metwork"
        titleLabel.textColor = .white
        titleLabel.font = Constants.Fonts.title
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(DiscoverablePeerCell.self, forCellWithReuseIdentifier: Constants.CellIdentifiers.discoverablePeer)
        
        // Discoverable Peers
        let topInset = view.frame.height / 1.8
        collectionView?.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        
        setupNetworkHistoryView()
        setupNetworkProfileView()
        
        // mpc
        appDelegate.mpcManager?.delegate = self
        appDelegate.mpcManager?.browser.startBrowsingForPeers()
        appDelegate.mpcManager?.advertiser.startAdvertisingPeer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.adversiseToggleDidChange), name: Constants.NotificationCenterNames.advertiseToggleSwitch.name, object: nil)
    }
    
    private func setupNetworkHistoryView() {
        view.addSubview(networkHistoryView)
        view.addConstraints(withFormat: "H:|[v0]|", views: networkHistoryView)
        view.addConstraints(withFormat: "V:|-270-[v0(100)]", views: networkHistoryView)
    }
    
    private func setupNetworkProfileView() {
        view.addSubview(networkProfileView)
        view.addConstraints(withFormat: "H:|[v0]|", views: networkProfileView)
        view.addConstraints(withFormat: "V:|[v0(270)]", views: networkProfileView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // MARK: TODO - unwrap
        return (appDelegate.mpcManager?.foundPeers.count)!
    }
    
    func adversiseToggleDidChange(sender: UISwitch) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.actionSheet)
        var actionTitle = String()
        
        if sender.isOn {
            actionTitle = "Make me visible"
        } else {
            actionTitle = "Make me invisible"
        }
        
        let visibilityAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (alertAction) -> Void in
            if sender.isOn {
                self.appDelegate.mpcManager?.advertiser.startAdvertisingPeer()
                print("Started Advertising")
            } else {
                self.appDelegate.mpcManager?.advertiser.stopAdvertisingPeer()
                print("Stopped Advertising")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            if sender.isOn {
                sender.setOn(false, animated: true)
            } else {
                sender.setOn(true, animated: true)
            }
        }
            
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func handleTempButtonTouch() {
        let tableViewController = ChatTableViewController()
        tableViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        tableViewController.preferredContentSize = CGSize(width: view.frame.width, height: 400)
        
        present(tableViewController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.discoverablePeer, for: indexPath) as! DiscoverablePeerCell
        cell.peerIdLabel.text = "\(appDelegate.mpcManager?.foundPeers[indexPath.item])"
        // add cell shadow
        return cell
    }
    
    // MARK: TODO - unwrap session and selectedPeer
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPeer = appDelegate.mpcManager?.foundPeers[indexPath.item] as MCPeerID!
        let session = appDelegate.mpcManager?.session
        appDelegate.mpcManager?.browser.invitePeer(selectedPeer!, to: session!, withContext: nil, timeout: 20)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width: view.frame.width, height: 50)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController: MPCManagerDelegate {
    func foundPeer() {
        collectionView?.reloadData()
    }
    
    func lostPeer() {
        collectionView?.reloadData()
    }
    
    func invintationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to network with you.", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.destructive) { (alertAction) -> Void in
            self.appDelegate.mpcManager?.invitationHandler(true, self.appDelegate.mpcManager?.session)
        }
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.appDelegate.mpcManager?.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // inform the collectionView that the device is connected with a peer
    func connectedWithPeer(peerID: MCPeerID) {
        OperationQueue.main.addOperation { () -> Void in
            self.performSegue(withIdentifier: Constants.MPC.segueChatIdentifier, sender: self)
        }
    }
}



































