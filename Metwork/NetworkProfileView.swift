//
//  NetworkProfileView.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

// MARK: TODO - Separate code between View and Controller
class NetworkProfileView: UIView {
    let store = DataStore.sharedInstance
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = Constants.Colors.blue
        return view
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Michael Young"
        label.textColor = .white
        label.font = Constants.Fonts.boldLarge
        return label
    }()
    
    let advertiseToggleButton: UISwitch = {
        let button = UISwitch()
        button.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        button.isOn = true
        button.setOn(true, animated: false)
        button.onTintColor = Constants.Colors.green
        button.addTarget(nil, action: #selector(MainViewController.advertiseToggleDidChange(sender:)), for: .valueChanged)
        return button
    }()
    
    let advertiseLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regMedium
        label.textColor = .white
        label.text = "Visible"
        return label
    }()
    
    lazy var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    //    let editProfileButton: UIButton = {
    //        let button = UIButton()
    //        let buttonImage = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
    //        button.tintColor = .white
    //        button.setImage(buttonImage, for: .normal)
    //        button.addTarget(nil, action: #selector(MainViewController.editProfileButtonTouched), for: .touchUpInside)
    //        return button
    //    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: NSNotification.Name(rawValue: "updateLabel") , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAdvertiseLabelVisible), name: NSNotification.Name(rawValue: "visibilityPostVisible"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAdvertiseLabelNotVisible), name: NSNotification.Name(rawValue: "visibilityPostNotVisible"), object: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabel() {
        if store.profileInput["displayName"] == "" {
            profileNameLabel.text = "\(UIDevice.current.name)"
            print("Device name\(UIDevice.current.name)")
        } else {
            profileNameLabel.text = store.profileInput["displayName"]
        }
    }
    
    func updateAdvertiseLabelVisible() {
        advertiseLabel.text = "Visible"
    }
    
    func updateAdvertiseLabelNotVisible() {
        advertiseLabel.text = "Not Visible"
    }
    
    func setupViews() {
        addSubview(cardView)
        addConstraints(withFormat: "H:|-16-[v0]-16-|", views: cardView)
        addConstraints(withFormat: "V:|-20-[v0]-20-|", views: cardView)
        
        addSubview(profileNameLabel)
        addConstraints(withFormat: "H:|-36-[v0]", views: profileNameLabel)
        addConstraints(withFormat: "V:|-35-[v0(22)]", views: profileNameLabel)
        
        addSubview(advertiseToggleButton)
        addConstraints(withFormat: "H:[v0]-18-|", views: advertiseToggleButton)
        addConstraints(withFormat: "V:|-30-[v0]", views: advertiseToggleButton)
        
        addSubview(advertiseLabel)
        addConstraints(withFormat: "H:[v0]-70-|", views: advertiseLabel)
        addConstraints(withFormat: "V:|-35-[v0]", views: advertiseLabel)
        
        addSubview(profileCollectionView)
        profileCollectionView.allowsMultipleSelection = true
        profileCollectionView.register(NetworkProfileCell.self, forCellWithReuseIdentifier: Constants.CellIdentifiers.profileNetwork)
        addConstraints(withFormat: "H:|-32-[v0]-32-|", views: profileCollectionView)
        addConstraints(withFormat: "V:|-90-[v0]-32-|", views: profileCollectionView)
        
        //        addSubview(editProfileButton)
        //        addConstraints(withFormat: "H:[v0(50)]-18-|", views: editProfileButton)
        //        addConstraints(withFormat: "V:|-21-[v0(50)]", views: editProfileButton)
        
        backgroundColor = Constants.Colors.purple
    }
}

extension NetworkProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.Images.networkProfile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.profileNetwork, for: indexPath) as! NetworkProfileCell
        cell.cellImageView.image = UIImage(named: Constants.Images.networkProfile[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = Constants.Colors.purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.profileNetwork, for: indexPath) as! NetworkProfileCell
        let key = Constants.Images.networkProfile[indexPath.item]
        store.outboundData[key] = store.profileInput[key]
        
        cell.toggleSelectedState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.profileNetwork, for: indexPath) as! NetworkProfileCell
        let key = Constants.Images.networkProfile[indexPath.item]
        store.outboundData[key] = nil

        cell.toggleSelectedState()
    }
}

extension NetworkProfileView: UICollectionViewDelegateFlowLayout {
    // MARK: TODO - dynamically size the last cell to fit the width to extra space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: 50, height: 50)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension NetworkProfileView: UICollectionViewDelegate {}

