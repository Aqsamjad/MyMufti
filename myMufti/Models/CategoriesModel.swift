//
//  Categories.Model.swift
//  myMufti
//
//  Created by Aqsa Amjad on 08/04/2022.
//

import Foundation

import Foundation

// MARK: - Welcome
struct CategoriesModel: Codable {
    let status: Bool
    let message: String
    let data: [Categories]
}

// MARK: - Datum
struct Categories: Codable {
    let questionID, userID, questionTitle, question: String
    let options, timeLimit, createdAt: String

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
    }
}
