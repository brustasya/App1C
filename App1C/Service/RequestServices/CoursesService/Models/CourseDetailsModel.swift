//
//  CourseDetailsModel.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

struct CourseDetailsModel: Codable {
    let title: String
    let description: String
    let chat: String
    let isStarted: Bool?
    let timetable: DaysModel?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case chat = "chat"
        case isStarted = "is_started"
        case timetable = "timetable"
        case type = "type"
    }
}

struct DaysModel: Codable {
    let days: [TimeTableDayModel]
}

struct TimeTableDayModel: Codable {
    let dayOfWeek: Int
    let from: String
    let to: String
    
    enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case from = "from"
        case to = "to"
    }
}
