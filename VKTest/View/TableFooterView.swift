//
//  TableFooterView.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class TableFooterView: UIView {
    
    var title: String? {
        didSet {
            let text = title ?? "0"
            countLabel.text = text + "записей"
            activityView.stopAnimating()
        }
    }
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showActivityView() {
        activityView.startAnimating()
    }
    
    private func configureUI() {
        addSubview(countLabel)
        countLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 12)
        
        addSubview(activityView)
        activityView.centerX(inView: self)
        activityView.anchor(top: countLabel.bottomAnchor,
                            paddingTop: 6)
    }
}
