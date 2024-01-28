//
//  WardsListPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

import Foundation

protocol WardsListPresenterProtocol: AnyObject {
    var wardsList: [WardModel]? { get set }

    func viewDidLoad()
    func rowsWillEnd()
    func didSelectRow(with ward: WardModel)
}

final class WardsListPresenter: WardsListPresenterProtocol {
    
    // MARK: - Properties
    
    var wardsList: [WardModel]?
    
    private weak var view: WardsListViewProtocol?
    private var router: WardsListRouterProtocol
    private var wardsListService: WardsListServiceProtocol
    
    private var pageInfo: PageInfoModel?
    
    // MARK: - Init
    
    init(view: WardsListViewProtocol,
         router: WardsListRouter,
         wardsListService: WardsListServiceProtocol) {
        self.view = view
        self.router = router
        self.wardsListService = wardsListService
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        fetchWardsList(cursor: nil)
    }
    
    func rowsWillEnd() {
        fetchWardsList(cursor: pageInfo?.endCursor)
    }
    
    func didSelectRow(with ward: WardModel) {
        let id = ward.id
        router.openWardInfoModule(by: id)
    }
    
    // MARK: - Private Methods
    
    private func fetchWardsList(cursor: String?) {
        wardsListService.fetchWardsList(cursor: cursor) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let wardsListModel):
                if self.wardsList == nil {
                    self.wardsList = wardsListModel.wards
                    self.pageInfo = wardsListModel.pageInfo
                    self.view?.reloadData()
                } else {
                    self.wardsList?.append(contentsOf: wardsListModel.wards)
                    self.pageInfo = wardsListModel.pageInfo
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
