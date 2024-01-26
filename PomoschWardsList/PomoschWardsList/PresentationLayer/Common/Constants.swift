//
//  Constants.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

import UIKit

// MARK: - Constants

enum Constants {
    
    // MARK: - WardsListModule
    
    static let tableViewRowHeight: CGFloat = 150
    static let tableViewCellInset = 10
    static let wardPhotoFrame = Int(tableViewRowHeight) - tableViewCellInset * 2
    static let wardsCountInResponse = 20
    
    // MARK: - WardInfoModule
    
    static let wardPhotoEdge = UIScreen.main.bounds.width * 0.8
    static let scrollViewTopOffset = 10
    static let stackViewInset = 10
}
