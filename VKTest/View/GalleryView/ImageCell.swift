//
//  ImageCell.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let reuseId = "ImageCell"
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGroupedBackground
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
