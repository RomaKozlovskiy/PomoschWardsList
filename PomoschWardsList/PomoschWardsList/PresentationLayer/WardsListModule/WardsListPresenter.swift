//
//  WardsListPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import Foundation
import WardsAPI

// MARK: - WardsListPresenterProtocol

protocol WardsListPresenterProtocol: AnyObject {
    var view: WardsListViewProtocol? { get set }
    var router: RouterProtocol { get set }
    var networkService: NetworkServiceProtocol { get set }
    var wardsList: [WardsListQuery.Data.Wards.Edge] { get set }
    
    func fetchWardsList()
    func fetchAdditionalWardsList()
    func rowDidSelect(with ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation)
}

// MARK: - WardsListPresenter

final class WardsListPresenter: WardsListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: WardsListViewProtocol?
    var router: RouterProtocol
    var networkService: NetworkServiceProtocol
    var wardsList: [WardsListQuery.Data.Wards.Edge] = []
    private var pageInfo: WardsListQuery.Data.Wards.PageInfo?
    
    // MARK: - Init
    
    init(view: WardsListViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    
    func fetchWardsList() {
        let query = WardsListQuery(
            first: GraphQLNullable<Int>(integerLiteral: Constants.wardsCountInResponse),
            after: .none)
        
        networkService.apollo.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let wardsList):
                self?.wardsList = wardsList.data?.wards?.edges?.compactMap { $0 } ?? []
                self?.pageInfo = wardsList.data?.wards?.pageInfo
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAdditionalWardsList() {
        let query = WardsListQuery(
            first: GraphQLNullable<Int>(integerLiteral: Constants.wardsCountInResponse),
            after: GraphQLNullable(stringLiteral: pageInfo?.endCursor ?? ""))
        
        networkService.apollo.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let wardsList):
                self?.wardsList.append(contentsOf: wardsList.data?.wards?.edges?.compactMap { $0 } ?? [])
                self?.pageInfo = wardsList.data?.wards?.pageInfo
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func rowDidSelect(with ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) {
        router.showWardInfo(with: ward)
    }
}
