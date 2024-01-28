//
//  Ward.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 28.01.2024.
//

import Foundation

struct WardModel {
    let id: String
    let fullName: String
    let city: String
    let photoUrl: String
}

struct WardInfoModel {
    let id: String
    let fullName: String
    let story: String
    let photoUrl: String
}

struct PageInfoModel {
    let hasNextPage: Bool
    let endCursor: String?
}

struct WardsListModel {
    let wards: [WardModel]
    let pageInfo: PageInfoModel?
}
