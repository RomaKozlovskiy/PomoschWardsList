//
//  WarsListModuleBuilder.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 27.01.2024.
//

import UIKit

final class WardsListModuleBuilder {
    
    func build(with navigationController: UINavigationController) -> UIViewController {
        let viewController = WardsListViewController()
        let router = WardsListRouter(navigationController: navigationController)
        let wardsService = WardsService()
        let presenter = WardsListPresenter(
            view: viewController,
            router: router,
            wardsService: wardsService
        )
        viewController.presenter = presenter
        return viewController
    }
}
