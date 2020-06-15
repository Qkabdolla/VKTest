//
//  BottomView.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private lazy var likesView = self.createView(image: #imageLiteral(resourceName: "like"))
    private lazy var commentsView = self.createView(image: #imageLiteral(resourceName: "comment"))
    private lazy var sharesView = self.createView(image: #imageLiteral(resourceName: "share"))
    private lazy var viewsView = self.createView(image: #imageLiteral(resourceName: "eye"))
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [likesView, commentsView, sharesView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private let breakView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        view.alpha = 0.5
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(commnets: String?, likes: String?, shares: String?, views: String?) {
        commentsView.label.text = commnets
        likesView.label.text = likes
        sharesView.label.text = shares
        viewsView.label.text = views
    }
    
    private func createView(image: UIImage) -> FooterCustomView {
        let view = FooterCustomView()
        view.imageView.image = image
        return view
    }
    
    private func configureUI() {
        addSubview(stackView)
        addSubview(viewsView)
        addSubview(breakView)
        
        stackView.anchor(left: leftAnchor,
                         paddingLeft: 16)
        stackView.centerY(inView: self)
                         
        viewsView.centerY(inView: self)
        viewsView.anchor(right: rightAnchor,
                         paddingRight: 16)
        
        breakView.anchor(left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         height: 0.5)
    }
}

class FooterCustomView: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        label.text = "30"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.setDimensions(width: 20, height: 20)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor,
                         paddingLeft: 4)
        
        label.centerY(inView: self)
        label.anchor(left: imageView.rightAnchor,
                     right: rightAnchor,
                     paddingLeft: 4,
                     paddingRight: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
