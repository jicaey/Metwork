//
//  NetworkProfileCell.swift
//  Metwork
//
//  Created by Michael Young on 2/19/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import Foundation
import UIKit

class NetworkProfileCell: BaseCell {
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
//    override var isHighlighted: Bool {
//        didSet {
//            // ternary operator to determine image tint color
//            cellImageView.tintColor = isHighlighted ? .white : Constants.Colors.purple
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            // ternary operator to determine image tint color
            cellImageView.tintColor = isSelected ? .white : Constants.Colors.purple
        }
    }
    
    override func setupViews() {
        addSubview(cellImageView)
        addConstraints(withFormat: "H:|[v0]|", views: cellImageView)
        addConstraints(withFormat: "V:|[v0]|", views: cellImageView)
    }
}
