//
//  HeaderView.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var date: String? {
        didSet {
            dateLabel.text = date
        }
    }
    
    lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 36 / 2
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Title text"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "suTitle text"
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(avatarView)
        addSubview(labelStackView)
        
        avatarView.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          paddingTop: 12,
                          paddingLeft: 16,
                          paddingBottom: 12,
                          width: 36,
                          height: 36)
        
        labelStackView.anchor(top: avatarView.topAnchor,
                              left: avatarView.rightAnchor,
                              bottom: avatarView.bottomAnchor,
                              right: rightAnchor,
                              paddingLeft: 12,
                              paddingRight: 16)
    }
    
}
