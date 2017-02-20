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
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = Constants.Colors.blue
        return view
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Michael Young Junior"
        label.textColor = .white
        label.font = Constants.Fonts.boldLarge
        return label
    }()
    
    let advertiseToggleButton: UISwitch = {
        let button = UISwitch()
        button.isOn = true
        button.setOn(true, animated: false)
        button.onTintColor = Constants.Colors.pink
        button.addTarget(nil, action: #selector(MainViewController.adversiseToggleDidChange(sender:)), for: .valueChanged)
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regMedium
        label.textColor = .white
        label.text = "michaelyoung.dev@gmail.com"
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(cardView)
        addConstraints(withFormat: "H:|-20-[v0]-20-|", views: cardView)
        addConstraints(withFormat: "V:|-20-[v0]-20-|", views: cardView)
        
        addSubview(profileNameLabel)
        addConstraints(withFormat: "H:|-36-[v0]", views: profileNameLabel)
        addConstraints(withFormat: "V:|-36-[v0(22)]", views: profileNameLabel)
        
        addSubview(advertiseToggleButton)
        addConstraints(withFormat: "H:[v0]-36-|", views: advertiseToggleButton)
        addConstraints(withFormat: "V:|-30-[v0]", views: advertiseToggleButton)
        
        addSubview(emailLabel)
        addConstraints(withFormat: "H:|-44-[v0]", views: emailLabel)
        addConstraints(withFormat: "V:|-55-[v0]", views: emailLabel)
        
        addSubview(profileCollectionView)
        profileCollectionView.allowsMultipleSelection = true
        profileCollectionView.register(NetworkProfileCell.self, forCellWithReuseIdentifier: Constants.CellIdentifiers.profileNetwork)
        addConstraints(withFormat: "H:|-32-[v0]-32-|", views: profileCollectionView)
        addConstraints(withFormat: "V:|-90-[v0]-32-|", views: profileCollectionView)
        
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

