//
//  WardInfoPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

import Foundation

protocol WardInfoPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class WardInfoPresenter: WardInfoPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: WardInfoViewProtocol?
    private var wardsService: WardsServiceProtocol
    
    private var wardID: String
    private var ward: WardInfoModel?
    
    // MARK: - Init
    
    init(view: WardInfoViewProtocol,
         wardsService: WardsServiceProtocol,
         wardID: String
    ) {
        self.view = view
        self.wardsService = wardsService
        self.wardID = wardID
    }
    
    //  MARK: - Public Methods
    
    func viewDidLoaded() {
        wardsService.fetchWardInfo(by: wardID, completion: { [weak self] result in
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
