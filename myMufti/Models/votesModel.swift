//
//  votesModel.swift
//  myMufti
//
//  Created by Aqsa Amjad on 02/04/2022.
//

import Foundation
import Foundation

// MARK: - Welcome
struct VoteModel: Codable {
    let status: Bool
    let message: String
    let data: VotesModel
}
// MARK: - DataClass
struct VotesModel: Codable {
    let voteID, questionID, userID, vote: String

    enum CodingKeys: String, CodingKey {
        case voteID = "vote_id"
        case questionID = "question_id"
        case userID = "user_id"
        case vote
    }
}
