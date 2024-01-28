//
//  WardsListViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

import UIKit
import SnapKit

private enum Constants {
    static let countOfWardsToTheEndOfList = 3
}

protocol WardsListViewProtocol: AnyObject {
    func reloadData()
}

final class WardsListViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WardsListPresenterProtocol!
    private lazy var tableView: UITableView = UITableView()
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Methods
  
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let reuseIdentifier = String(describing: WardsListTableViewCell.self)
        
        tableView.register(WardsListTableViewCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - WardsListViewProtocol 

extension WardsListViewController: WardsListViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension WardsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.wardsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: WardsListTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath) as? WardsListTableViewCell else {
            fatalError("The TableView could not dequeue a WardsListTableViewCell in ViewController.")
        }
        
        guard let ward = presenter.wardsList?[indexPath.row] else {
            return cell
        }
        
        cell.setupWith(ward: ward)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension WardsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        WardsListTableViewCell.rowHeight()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let wardsCount = presenter?.wardsList?.count else { return }
        if indexPath.row == wardsCount - Constants.countOfWardsToTheEndOfList {
            presenter.rowsWillEnd()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ward = presenter.wardsList?[indexPath.row] else { return } 
        presenter.didSelectRow(with: ward)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
