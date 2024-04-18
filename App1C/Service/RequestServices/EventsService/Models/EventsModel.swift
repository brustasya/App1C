//
//  EventsModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct EventsModel: Codable {
    let events: [EventServiceModel]
}

struct EventServiceModel: Codable {
    let id: Int
    let title: String
    let deadline: String?
    let newEvent: Bool?
}
