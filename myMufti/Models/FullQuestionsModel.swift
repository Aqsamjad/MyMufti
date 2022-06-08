//
//  FullQuestionsModel.swift
//  myMufti
//
//  Created by Aqsa Amjad on 29/03/2022.
//

import Foundation
// MARK: - Welcome
struct FullQuestionModel: Codable {
    let status: Bool
    let message: String
    let data: [FullQuestion]
}

// MARK: - Datum
struct FullQuestion: Codable {
    let questionID: String
    let userID: UsersID
    let questionTitle, question, options, timeLimit: String
    let createdAt, userVote: String
    let muftiAnswer: String
    let questionCategories: [QuestionsCategory]
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



// MARK: - QuestionCategory
struct QuestionsCategory: Codable {
    let id, questionID, categories: String

    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case categories
    }
}

// MARK: - UserID
struct UsersID: Codable {
    let id: String
    let name: String
    let image: String
}


