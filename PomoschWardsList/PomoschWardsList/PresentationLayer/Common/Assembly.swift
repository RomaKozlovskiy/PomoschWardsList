//
//  Assembly.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit

// MARK: - AssemblyProtocol

protocol AssemblyProtocol: AnyObject {
    func createWardsListModule(router: RouterProtocol) -> UIViewController
}

// MARK: - Assembly

final class Assembly: AssemblyProtocol {
    func createWardsListModule(router: RouterProtocol) -> UIViewController {
        let view = WardsListViewController()
        let networkService = NetworkService()
        let presenter = WardsListPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
