//
//  WardsListService.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

import Foundation
import Apollo
import WardsAPI

protocol WardsListServiceProtocol: AnyObject {
    func fetchWardsList(
        cursor: String?,
        completion: @escaping (Result<WardsListModel, Error>) -> Void)
}

final class WardsListService: WardsListServiceProtocol {
    
    private let apollo: ApolloClient = ApolloClient(url: Config.graphqlURL)
    
    func fetchWardsList(
        cursor: String?,
        completion: @escaping (Result<WardsListModel, Error>) -> Void) {
            
            if cursor == nil {
                let query = WardsListQuery(first: 20, after: nil)
                
                apollo.fetch(query: query) { [weak self] result in
                    switch result {
                    case .success(let wardsListQuery):
                        
                        guard let wardsListModel = self?.getWardsListModel(
                            from: wardsListQuery.data!) else {
                            return
                        }
                        completion(.success(wardsListModel))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if cursor != nil {
                let query = WardsListQuery(first: 20, after: GraphQLNullable(stringLiteral: cursor!))
                
                apollo.fetch(query: query) { [weak self] result in
                    switch result {
                    case .success(let wardsListQuery):
                        guard let wardsListModel = self?.getWardsListModel(
                            from: wardsListQuery.data!) else {
                            return
                        }
                        completion(.success(wardsListModel))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    
    // MARK: - Private Methods
    
    private func getWardsModel(
        from wardsListQuery: [WardsListQuery.Data.Wards.Edge]?) -> [WardModel] {
        let wardsModel = wardsListQuery?.compactMap({ wardsListQuery in
            WardModel(id: wardsListQuery.node.id,
                      fullName: wardsListQuery.node.publicInformation.name.displayName,
                      dateOfBirth: wardsListQuery.node.publicInformation.dateOfBirth,
                      dateOfDeath: wardsListQuery.node.publicInformation.dateOfDeath,
                      city: wardsListQuery.node.publicInformation.city,
                      story: wardsListQuery.node.publicInformation.story,
                      photoUrl: wardsListQuery.node.publicInformation.photo.url)
        })
        
        return wardsModel ?? []
    }
    
    private func getPageInfo(
        from pageInfo: WardsListQuery.Data.Wards.PageInfo?) -> PageInfoModel? {
        let pageInfo = PageInfoModel(
            hasNextPage: pageInfo?.hasNextPage ?? false,
            endCursor: pageInfo?.endCursor)
        return pageInfo
    }
    
    private func getWardsListModel(
        from wardsListQuery: WardsListQuery.Data) -> WardsListModel {
        let wardsModel = getWardsModel(from: wardsListQuery.wards?.edges)
        let pageInfoModel = getPageInfo(from: wardsListQuery.wards?.pageInfo)
        let wardsListModel = WardsListModel(wards: wardsModel, paheInfo: pageInfoModel)
        return wardsListModel
    }
}
