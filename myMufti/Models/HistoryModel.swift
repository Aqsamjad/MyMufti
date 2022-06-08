//
//  HistoryModel.swift
//  myMufti
//
//  Created by Qazi on 15/03/2022.
//
import Foundation

// MARK: - Welcome
struct HistoryModel: Codable {
    let status: Bool
    let message: String
    let data: [History]
}

// MARK: - Datum
struct History: Codable {
    let questionID, userID: String
    let questionTitle: QuestionTitle
    let question: Question
    let options, timeLimit, createdAt: String
    let totalVote: Int
    let votePerctageFor1StAns, votePerctageFor2NdAns: Double

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
        case totalVote = "total_vote"
        case votePerctageFor1StAns = "vote_perctage_for_1st_ans"
        case votePerctageFor2NdAns = "vote_perctage_for_2nd_ans"
    }
}

enum Question: String, Codable {
    case howToMakeAnAPI = "how to make an api"
}

enum QuestionTitle: String, Codable {
    case question1 = "question 1"
}
