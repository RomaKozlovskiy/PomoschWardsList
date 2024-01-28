//
//  WardsListRouter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 27.01.2024.
//

import UIKit

protocol WardsListRouterProtocol {
    func openWardInfoModule()
}

final class WardsListRouter: WardsListRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openWardInfoModule() {
        let wardInfoModule = WardsListModuleBuilder().build()
        navigationController.present(wardInfoModule, animated: true)
    }
}
