//
//  WardsService.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 24.01.2024.
//

import Foundation
import Apollo
import WardsAPI

private enum Constants {
    static let countOfWardsInRequest = 40
}

protocol WardsServiceProtocol: AnyObject {
    func fetchWardsList(
        cursor: String?,
        completion: @escaping (Result<WardsListModel, Error>) -> Void
    )
    
    func fetchWardInfo(
        by id: String,
        completion: @escaping (Result<WardInfoModel, Error>) -> Void
    )
}

final class WardsService: WardsServiceProtocol {
    
    private let apollo: ApolloClient = ApolloClient(url: Config.graphqlURL)
    private let firstQuery = GraphQLNullable<Int>(integerLiteral: Constants.countOfWardsInRequest)
    
    func fetchWardInfo(
        by id: String,
        completion: @escaping (Result<WardInfoModel, Error>) -> Void
    ) {
        let query = WardInfoQuery(id: id)
        apollo.fetch(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let wardInfo):
                    guard let wardInfo = self?.wardInfoModel(from: wardInfo) else { return }
                    completion(.success(wardInfo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchWardsList(
        cursor: String?,
        completion: @escaping (Result<WardsListModel, Error>) -> Void
    ) {
        let afterQuery: GraphQLNullable<String>
        if let cursor = cursor {
            afterQuery = GraphQLNullable(stringLiteral: cursor)
        } else {
            afterQuery = nil
        }
        let query = WardsListQuery(first: firstQuery, after: afterQuery)
        
        apollo.fetch(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let wardsListQuery):
                    guard let data = wardsListQuery.data,
                          let wardsListModel = self?.wardsListModel(from: data) else {
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
    
    private func wardsModel(
        from wardsListData: [WardsListQuery.Data.Wards.Edge]?) -> [WardModel] {
            let wardsModel = wardsListData?.compactMap({ wardsListData in
                WardModel(
                    id: wardsListData.node.id,
                    fullName: wardsListData.node.publicInformation.name.displayName,
                    city: wardsListData.node.publicInformation.city,
                    photoUrl: wardsListData.node.publicInformation.photo.url)
            })
            
            return wardsModel ?? []
        }
    
    private func pageInfoModel(
        from pageInfoData: WardsListQuery.Data.Wards.PageInfo?
    ) -> PageInfoModel? {
        let pageInfo = PageInfoModel(
            hasNextPage: pageInfoData?.hasNextPage ?? false,
            endCursor: pageInfoData?.endCursor)
        return pageInfo
    }
    
    private func wardsListModel(
        from wardsListData: WardsListQuery.Data
    ) -> WardsListModel {
        let wardsModel = wardsModel(from: wardsListData.wards?.edges)
        let pageInfoModel = pageInfoModel(from: wardsListData.wards?.pageInfo)
        let wardsListModel = WardsListModel(wards: wardsModel, pageInfo: pageInfoModel)
        return wardsListModel
    }
    
    private func wardInfoModel(
        from wardInfoData: GraphQLResult<WardInfoQuery.Data>
    ) -> WardInfoModel {
        let wardInfoModel = WardInfoModel(
            id: wardInfoData.data?.wardById?.id ?? "",
            fullName: wardInfoData.data?.wardById?.publicInformation.name.displayName ?? "",
            story: wardInfoData.data?.wardById?.publicInformation.story ?? "",
            photoUrl: wardInfoData.data?.wardById?.publicInformation.photo.url ?? "")
        return wardInfoModel
    }
}
