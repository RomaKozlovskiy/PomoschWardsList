//
//  NetworkService.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

// MARK: - Import

import Apollo
import Foundation

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    var apollo: ApolloClient { get }
}

// MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
    var apollo: ApolloClient = ApolloClient(url: URL(string: "https://api.pomosch.app/graphql")!)
}
