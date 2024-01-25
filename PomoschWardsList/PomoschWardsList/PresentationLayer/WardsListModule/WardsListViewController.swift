//
//  WardsListViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

// MARK: - Import

import UIKit

// MARK: - WardsListViewProtocol

protocol WardsListViewProtocol: AnyObject {
    
}

// MARK: - WardsListViewController

final class WardsListViewController: UIViewController {
    var presenter: WardsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
}

// MARK: - WardsListViewProtocol Implementation

extension WardsListViewController: WardsListViewProtocol {
    
}
