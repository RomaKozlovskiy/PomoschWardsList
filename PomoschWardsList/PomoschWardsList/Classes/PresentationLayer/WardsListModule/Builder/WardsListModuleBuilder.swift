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
        let wardsListService = WardsListService()
        let presenter = WardsListPresenter(
            view: viewController,
            router: router,
            wardsListService: wardsListService)
        viewController.presenter = presenter
        return viewController
    }
}
