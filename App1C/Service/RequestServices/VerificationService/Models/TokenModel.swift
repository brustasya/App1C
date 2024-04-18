//
//  TokenModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct TokenResponseModel: Codable {
    let token: TokenModel?
    let uid: Int
    let isFirstAuth: Bool
}

struct TokenModel: Codable {
    let accessToken: String
    let accessTokenExpirationDate: String
    let refreshToken: String
    let refreshTokenExpirationDate: String
}
