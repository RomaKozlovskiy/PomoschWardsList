//
//  Router.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit
import WardsAPI

// MARK: - RouterProtocol

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var assembly: AssemblyProtocol { get set }
    
    func initialViewController()
    func showWardInfo(with wardInfo: WardsListQuery.Data.Wards.Edge.Node.PublicInformation)
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
    
    func showWardInfo(with wardInfo: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) {
        let wardInfoViewController = assembly.createWardInfoModule(router: self, ward: wardInfo)
        navigationController.pushViewController(wardInfoViewController, animated: true)
    }
}
