//
//  UsersModel.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

struct UsersModel: Codable {
    let users: [UserServerModel]
}

struct UserServerModel: Codable {
    let id: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
    }
}
