//
//  UserCommentModel.swift
//  myMufti
//
//  Created by Qazi on 11/03/2022.
//

import Foundation
import Foundation

// MARK: - Welcome
struct UserCommentModel: Codable {
    let status: Bool
    let message: String
    let data: UserComment
}

// MARK: - DataClass
struct UserComment: Codable {
    let commentID, questionID, userID, comment: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case questionID = "question_id"
        case userID = "user_id"
        case comment
        case createdAt = "created_at"
    }
}
