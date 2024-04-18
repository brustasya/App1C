//
//  AdminsModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct AdminsModel: Codable {
    let users: [AdminServerModel]
}

struct AdminServerModel: Codable {
    let id: Int
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
    }
}
