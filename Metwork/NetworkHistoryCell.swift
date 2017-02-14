//
//  NetworkHistoryCell.swift
//  Metwork
//
//  Created by Michael Young on 2/13/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import UIKit

class NetworkHistoryCell: BaseCell {
    
    let backgroundCell: UIView = {
        let bg = UIView()
        bg.layer.cornerRadius = 5
        bg.backgroundColor = Constants.Colors.pink
        return bg
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "JamieCampbellBower")
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
    
       
        addSubview(backgroundCell)
         addSubview(imageView)
        
        addConstraints(withFormat: "H:|-8-[v0]-8-|", views: backgroundCell)
        addConstraints(withFormat: "V:|-8-[v0]-8-|", views: backgroundCell)
        addConstraints(withFormat: "H:|-16-[v0(28)]", views: imageView)
        addConstraints(withFormat: "V:[v0(28)]-16-|", views: imageView)
        
        backgroundColor = Constants.Colors.purple
    }
}
