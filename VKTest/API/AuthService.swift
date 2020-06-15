//
//  AuthService.swift
//  VKTest
//
//  Created by Мадияр on 6/4/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authShow(vc: UIViewController)
    func authLogin()
    func authLoginDidFail()
}

final class AuthService: NSObject {
    
    static let shared = AuthService()
    
    private let appId = "7498745"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["friends", "wall"]
        VKSdk.wakeUpSession(scope) { [weak self] (status, error) in
            switch status {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                self?.delegate?.authLogin()
            default:
                self?.delegate?.authLogin()
            }
        }
    }
    
}

extension AuthService: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authLogin()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authLoginDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authShow(vc: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
    }
}
