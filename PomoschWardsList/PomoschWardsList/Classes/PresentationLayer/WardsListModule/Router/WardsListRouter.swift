//
//  WardsListRouter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 27.01.2024.
//

import UIKit

protocol WardsListRouterProtocol {
    func openWardInfoModule(by id: String)
}

final class WardsListRouter: WardsListRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openWardInfoModule(by id: String) {
        let wardInfoModule = WardInfoModuleBuilder().build(by: id)
        navigationController.present(wardInfoModule, animated: true)
    }
}
