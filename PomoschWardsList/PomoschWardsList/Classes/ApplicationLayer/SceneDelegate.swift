//
//  SceneDelegate.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let viewController = WardsListModuleBuilder().build(with: navigationController)
        navigationController.setViewControllers([viewController], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
