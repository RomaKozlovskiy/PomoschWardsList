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
    private var router: WardsListRouter
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
        wardsListService.fetchWardsList(cursor: nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let wardsListModel):
                if self.wardsList == nil {
                    self.wardsList = wardsListModel.wards
                    self.view?.reloadData()
                } else {
                    self.wardsList?.append(contentsOf: wardsListModel.wards)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func rowsWillEnd() {
        
    }
    
    func didSelectRow(with ward: WardModel) {
        
    }
}






    //    func fetchWardsList() {
    //        let query = WardsListQuery(
    //            first: GraphQLNullable<Int>(integerLiteral: Constants.wardsCountInResponse),
    //            after: .none) //TODO: перенести в сервис с комплишном
    //        //TODO: перенести в сервис
    //        networkService.apollo.fetch(query: query) { [weak self] result in
    //            switch result {
    //            case .success(let wardsList):
    //                self?.wardsList = wardsList.data?.wards?.edges?.compactMap { $0 } ?? []
    //                self?.pageInfo = wardsList.data?.wards?.pageInfo
    //                DispatchQueue.main.async {
    //                    self?.view?.reloadData()
    //                }
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    
    //func fetchWardsList(page: Int = 0, completion: @escaping: (Result<[Ward], Error>) -> Void) {}
    
    //TODO: сделать единый метод
    //    func fetchAdditionalWardsList() {
    //        let query = WardsListQuery(
    //            first: GraphQLNullable<Int>(integerLiteral: Constants.wardsCountInResponse),
    //            after: GraphQLNullable(stringLiteral: pageInfo?.endCursor ?? ""))
    //
    //        networkService.apollo.fetch(query: query) { [weak self] result in
    //            switch result {
    //            case .success(let wardsList):
    //                self?.wardsList.append(contentsOf: wardsList.data?.wards?.edges?.compactMap { $0 } ?? [])
    //                self?.pageInfo = wardsList.data?.wards?.pageInfo
    //                DispatchQueue.main.async {
    //                    self?.view?.reloadData()
    //                }
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    
    //    func rowDidSelect(with ward: Ward) {
    //        //TODO: сделать номальный роутинг с WardsListRouter
    //        //router.showWardInfo(with: ward)
    //    }
    //}
    

