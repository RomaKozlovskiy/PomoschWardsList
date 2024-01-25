//
//  Config.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import Foundation

// MARK: - Config

struct Config {
    enum Key: String {
        case graphqlURL
    }
    
    static var graphqlURL: URL {
        guard let stringURL = Bundle.main.infoDictionary?[Key.graphqlURL.rawValue] as? String else {
            fatalError("Value for key \(Key.graphqlURL.rawValue) not found!")
        }
        guard let graphqlURL = URL(string: stringURL) else {
            fatalError("Invalid server URL: \(stringURL)")
        }
        return graphqlURL
    }
}
