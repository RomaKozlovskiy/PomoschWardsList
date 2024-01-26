//
//  Assembly.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit
import WardsAPI

// MARK: - AssemblyProtocol

protocol AssemblyProtocol: AnyObject {
    func createWardsListModule(router: RouterProtocol) -> UIViewController
    func createWardInfoModule(router: RouterProtocol,
                              ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) -> UIViewController
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
    
    func createWardInfoModule(router: RouterProtocol, ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) -> UIViewController {
        let view = WardInfoViewController()
        let presenter = WardInfoPresenter(view: view, ward: ward)
        view.presenter = presenter
        return view
    }
}
