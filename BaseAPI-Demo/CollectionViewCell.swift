//
//  CollectionViewCell.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var idLabel: UILabel!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let fullScreenSize = UIScreen.main.bounds.size
        self.backgroundColor = .white
        imageView = UIImageView(frame: CGRect(
            x: 0, y: 0,
            width: fullScreenSize.width/4,
            height: fullScreenSize.width/4
        ))
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        
        idLabel = UILabel(frame: CGRect(
            x: 0, y: 0,
            width: fullScreenSize.width/4,
            height: fullScreenSize.width/4/2
        ))
        idLabel.textAlignment = .center
        
        self.addSubview(idLabel)
        
        titleLabel = UILabel(frame: CGRect(
            x: 0, y: fullScreenSize.width/4/2,
            width: fullScreenSize.width/4,
            height: fullScreenSize.width/4/2
        ))
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.addSubview(titleLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
