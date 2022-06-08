//
//  GeneralResponseModel.swift
//  myMufti
//
//  Created by Qazi on 29/01/2022.
//


import Foundation

// MARK: - Welcome
struct GeneralResponseModel: Codable {
    let status: Bool
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
}
