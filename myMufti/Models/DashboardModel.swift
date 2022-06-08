//
//  DashboardModel.swift
//  myMufti
//
//  Created by Qazi on 11/03/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DashboardModel: Codable {
    let status: Bool
    let message: String
    let data: [Dashboard]
}

// MARK: - Datum
struct Dashboard: Codable {
    let questionID: String
    let userID: UserID
    let questionTitle, question, options, timeLimit: String
    let createdAt, userVote: String
    let muftiAnswer: MuftiAnswer
    let questionCategories: [QuestionCategorys]
    let questionComment, totalVote, totalVoteForYes, totalVoteForNo: Int

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
        case userVote = "user_vote"
        case muftiAnswer = "mufti_answer"
        case questionCategories = "question_categories"
        case questionComment = "question_comment"
        case totalVote = "total_vote"
        case totalVoteForYes = "total_vote_for_yes"
        case totalVoteForNo = "total_vote_for_no"
    }
}

// MARK: - MuftiAnswer
struct MuftiAnswer: Codable {
}

// MARK: - QuestionCategory
struct QuestionCategorys: Codable {
    let id, questionID, categories: String

    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case categories
    }
}

// MARK: - UserID
struct UserID: Codable {
    let id: String
    let name: String
    let image: String
}

