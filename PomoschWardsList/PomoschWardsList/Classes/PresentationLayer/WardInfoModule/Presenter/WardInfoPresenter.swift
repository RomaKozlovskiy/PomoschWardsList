//
//  WardInfoPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

// MARK: - Import

import Foundation

// MARK: - WardInfoPresenterProtocol

protocol WardInfoPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

// MARK: - WardInfoPresenter

final class WardInfoPresenter: WardInfoPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: WardInfoViewProtocol?
    private var wardsListService: WardsListServiceProtocol?
    private var ward: WardInfoModel?
    private var wardID: String?
    
    // MARK: - Init
    
    init(view: WardInfoViewProtocol?, wardsListService: WardsListServiceProtocol?, wardID: String?) {
        self.view = view
        self.wardsListService = wardsListService
        self.wardID = wardID
    }
    
//     MARK: - Public Methods
    
    func viewDidLoaded() {
        wardsListService?.fetchWardInfo(by: wardID ?? "", completion: { [weak self] result in
            switch result {
            case .success(let ward):
                self?.ward = ward
                self?.view?.displayWardInfo(with: ward)
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
