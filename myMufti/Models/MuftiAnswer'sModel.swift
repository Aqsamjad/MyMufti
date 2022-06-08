//
//  MuftiAnswer'sModel.swift
//  myMufti
//
//  Created by Aqsa Amjad on 02/04/2022.
//

import Foundation

import Foundation

// MARK: - Welcome
struct MuftiAnswerModel: Codable {
    let status: Bool
    let message: String
    let data: MuftisAnswerModel
}

// MARK: - DataClass
struct MuftisAnswerModel: Codable {
    let answerID, muftiID, questionID, answer: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case muftiID = "mufti_id"
        case questionID = "question_id"
        case answer
    }
}
