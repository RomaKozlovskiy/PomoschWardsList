//
//  Router.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit

// MARK: - RouterProtocol

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var assembly: AssemblyProtocol { get set }
    
    func initialViewController()
}

// MARK: - Router

final class Router: RouterProtocol {
    var navigationController: UINavigationController
    var assembly: AssemblyProtocol
    
    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func initialViewController() {
        let viewController = assembly.createWardsListModule(router: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
