//
//  WardsListPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import Foundation

// MARK: - WardsListPresenterProtocol

protocol WardsListPresenterProtocol: AnyObject {
    var view: WardsListViewProtocol? { get set }
    var router: RouterProtocol { get set }
    var networkService: NetworkServiceProtocol { get set }
}

// MARK: - WardsListPresenter

final class WardsListPresenter: WardsListPresenterProtocol {
    weak var view: WardsListViewProtocol?
    var router: RouterProtocol
    var networkService: NetworkServiceProtocol
    
    init(view: WardsListViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
}
