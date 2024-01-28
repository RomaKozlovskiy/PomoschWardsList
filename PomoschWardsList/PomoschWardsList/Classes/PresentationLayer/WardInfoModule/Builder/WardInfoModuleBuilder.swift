//
//  WardsInfoModuleBuilder.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 28.01.2024.
//

import UIKit

final class WardInfoModuleBuilder {
    
    func build(by id: String) -> UIViewController {
        let viewController = WardInfoViewController()
        let wardsService = WardsService()
        let presenter = WardInfoPresenter(
            view: viewController,
            wardsService: wardsService,
            wardID: id
        )
        viewController.presenter = presenter
        return viewController
    }
}
