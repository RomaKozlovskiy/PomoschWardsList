//
//  WardsListViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

// MARK: - Import

import UIKit
import SnapKit

// MARK: - WardsListViewProtocol

protocol WardsListViewProtocol: AnyObject {
    func reloadData()
}

// MARK: - WardsListViewController

final class WardsListViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WardsListPresenter?
    private let tableView: UITableView = UITableView()
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        applyConstraints()
        setupTableView()
        
        presenter?.fetchWardsList()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.register(WardsListTableViewCell.self,
                           forCellReuseIdentifier: String(describing: WardsListTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - WardsListViewProtocol Implementation

extension WardsListViewController: WardsListViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension WardsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.wardsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WardsListTableViewCell.self), for: indexPath) as? WardsListTableViewCell else {
            fatalError("The TableView could not dequeue a WardsListTableViewCell in ViewController.")
        }
        
        if let ward = presenter?.wardsList[indexPath.row].node.publicInformation {
            cell.setupWith(ward: ward)
            
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension WardsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let wardsCount = presenter?.wardsList.count else { return }
        if indexPath.row == wardsCount - 3 {
            presenter?.fetchAdditionalWardsList()
        }
    }
}

