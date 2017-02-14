//
//  MainViewController.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

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
        print("Top Inset: \(topInset)")
        collectionView?.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        
        setupNetworkHistoryView()
        setupNetworkProfileView()
        
        // mpc
        appDelegate.mpcManager?.delegate = self
        appDelegate.mpcManager?.browser.startBrowsingForPeers()
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
        // MARK TODO: - unwrap
        return (appDelegate.mpcManager?.foundPeers.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.discoverablePeer, for: indexPath) as! DiscoverablePeerCell
        cell.peerIdLabel.text = "\(appDelegate.mpcManager?.foundPeers[indexPath.item])"
        // test
//        cell.layer.shadowOpacity = 1
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowRadius = 10
//        cell.layer.shadowOffset = CGSize(width: 0, height: -1)
//        cell.layer.cornerRadius = 3
        return cell
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
    func found() {
        collectionView?.reloadData()
    }
    
    func lostPeer() {
        collectionView?.reloadData()
    }
}



































