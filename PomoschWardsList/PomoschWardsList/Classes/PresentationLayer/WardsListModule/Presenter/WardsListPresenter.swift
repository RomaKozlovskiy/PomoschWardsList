//
//  WardsListPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

import Foundation

protocol WardsListPresenterProtocol: AnyObject {
    var wardsList: [WardModel] { get set }

    func viewDidLoad()
    func tableViewDidScrollToEnd()
    func didSelectRow(at index: Int)
}

final class WardsListPresenter: WardsListPresenterProtocol {
    
    // MARK: - Properties
    
    var wardsList = [WardModel]()
    
    private weak var view: WardsListViewProtocol?
    private var router: WardsListRouterProtocol
    private var wardsService: WardsServiceProtocol
    
    private var pageInfo: PageInfoModel?
    private var isLoading = false
    
    // MARK: - Init
    
    init(view: WardsListViewProtocol,
         router: WardsListRouterProtocol,
         wardsService: WardsServiceProtocol) {
        self.view = view
        self.router = router
        self.wardsService = wardsService
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        fetchWardsList(cursor: nil)
    }
    
    func tableViewDidScrollToEnd() {
        fetchWardsList(cursor: pageInfo?.endCursor)
    }
    
    func didSelectRow(at index: Int) {
        if index < wardsList.count {
            let ward = wardsList[index]
            router.openWardInfoModule(by: ward.id)
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchWardsList(cursor: String?) {
        guard !isLoading else { return }
        isLoading = true
        wardsService.fetchWardsList(cursor: cursor) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let wardsListModel):
                self.wardsList.append(contentsOf: wardsListModel.wards)
                self.pageInfo = wardsListModel.pageInfo
                self.view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
