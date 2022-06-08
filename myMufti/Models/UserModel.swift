//
//  UserModel.swift
//  myMufti
//
//  Created by Qazi on 24/01/2022.
//

import Foundation
import Foundation

// MARK: - Welcome
struct UserModel: Codable {
    let status: Bool
    let message: String
    let data: User?
}

// MARK: - DataClass
struct User: Codable {
    let id, name, email, password: String?
    let phoneNumber, image, status, createdAt: String?
    let modified, code, fCode, gToken: String?
    let fbToken, aCode, nationality, userType: String?
    let degree, instituteName, experianceFrom, experianceTo: String?
    let shopRegistered, emailCode: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, password
        case phoneNumber = "phone_number"
        case image, status
        case createdAt = "created_at"
        case modified, code
        case fCode = "f_code"
        case gToken = "g_token"
        case fbToken = "fb_token"
        case aCode = "a_code"
        case nationality
        case userType = "user_type"
        case degree
        case instituteName = "institute_name"
        case experianceFrom = "experiance_from"
        case experianceTo = "experiance_to"
        case shopRegistered = "shop_registered"
        case emailCode = "email_code"
    }
}
