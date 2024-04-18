//
//  CurrentEventsModel.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

struct CurrentEventsModel: Codable {
    let events: [CurrentEventModel]
}

struct CurrentEventModel: Codable {
    let id: Int
    let title: String
    let deadline: String?
    let isExpired: Bool?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case deadline = "deadline"
        case isExpired = "is_expired"
        case type = "type"
    }
}
