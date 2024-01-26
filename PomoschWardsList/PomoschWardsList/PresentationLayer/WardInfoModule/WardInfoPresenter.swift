//
//  WardInfoPresenter.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

// MARK: - Import

import Foundation
import WardsAPI

// MARK: - WardInfoPresenterProtocol

protocol WardInfoPresenterProtocol: AnyObject {
    var view: WardInfoViewProtocol? { get set }
    var ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation { get set }
    
    func viewDidLoaded()
}

// MARK: - WardInfoPresenter

final class WardInfoPresenter: WardInfoPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: WardInfoViewProtocol?
    var ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation
    
    // MARK: - Init
    
    init(view: WardInfoViewProtocol?, ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) {
        self.view = view
        self.ward = ward
    }
    
    // MARK: - Public Methods
    
    func viewDidLoaded() {
        if let dateOfDeath = ward.dateOfDeath {
            let dateOfBirth = dateFormatter(ward.dateOfBirth)
            let dateOfDeath = dateFormatter(dateOfDeath)
            let yearsOfLife = dateOfBirth + " - " + dateOfDeath
            view?.showWardInfo(with: ward, yearsOfLife: yearsOfLife)
        } else {
            let dateOfBirth = dateFormatter(ward.dateOfBirth)
            view?.showWardInfo(with: ward, yearsOfLife: dateOfBirth)
        }
    }
    
    // MARK: - Private Methods
    
    func dateFormatter(_ wardDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: wardDate) {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
