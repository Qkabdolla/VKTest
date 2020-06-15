//
//  SceneDelegate.swift
//  VKTest
//
//  Created by Мадияр on 6/4/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        AuthService.shared.delegate = self
        let viewController = AuthViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
        configureNavigationBar()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = .systemBlue
        appearance.tintColor = UIColor.white
        appearance.isTranslucent = true
        appearance.barTintColor = .systemBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.prefersLargeTitles = false
        appearance.barStyle = .black
    }

}

extension SceneDelegate: AuthServiceDelegate {
    func authShow(vc: UIViewController) {
        window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func authLogin() {
        let nvc = UINavigationController(rootViewController: NewsViewController())
        window?.rootViewController = nvc
    }
    
    func authLoginDidFail() {
        print("Login Fail")
    }
}

