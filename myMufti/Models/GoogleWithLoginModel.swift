//
//  GoogleWithLoginModel.swift
//  myMufti
//
//  Created by Qazi on 01/03/2022.
//

import Foundation

// MARK: - Welcome
struct GoogleWithLoginModel: Codable {
    let status: Bool
    let message: String
    let data: GoogleWithLogin
}
// MARK: - DataClass
struct GoogleWithLogin: Codable {
    let id, name, email, password: String
    let phoneNumber, image, status, createdAt: String
    let modified, code, fCode, gToken: String
    let fbToken, aCode, nationality, userType: String
    let degree, degreeImage, degreeStartDate, degreeEndDate: String
    let instituteName, experianceFrom, experianceTo, shopRegistered: String
    let emailCode, userToken: String

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
        case degreeImage = "degree_image"
        case degreeStartDate = "degree_start_date"
        case degreeEndDate = "degree_end_date"
        case instituteName = "institute_name"
        case experianceFrom = "experiance_from"
        case experianceTo = "experiance_to"
        case shopRegistered = "shop_registered"
        case emailCode = "email_code"
        case userToken = "user_token"
    }
}
