//
//  ViewController.swift
//  VKTest
//
//  Created by Мадияр on 6/4/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK: - Properties
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 60
        btn.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc private func handleLoginTap() {
        AuthService.shared.wakeUpSession()
    }
    
    // MARK: - Helpers
    // MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        loginButton.center(inView: view)
        loginButton.setDimensions(width: 120, height: 120)
    }
}

