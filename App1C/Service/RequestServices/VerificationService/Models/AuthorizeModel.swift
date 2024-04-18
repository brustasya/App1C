//
//  AuthorizeModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct AuthorizeModel: Codable {
    let login: String
    let password: String
    let role: String
}
