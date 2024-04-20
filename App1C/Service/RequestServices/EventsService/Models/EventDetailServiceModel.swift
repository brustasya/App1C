//
//  EventDetailServiceModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct EventDetailServiceModel: Codable {
    let id: Int
    let title: String
    let description: String
    let deadline: String?
    let type: String
    let speechType: String?
    let timetableLink: String?
    let zoomLink: String?
    let ownDiplomaDeadline: String?
    let universityDiplomaDeadline: String?
    let workDiplomaDeadline: String?
    let themes: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case deadline = "deadline"
        case type = "type"
        case speechType = "speech_type"
        case timetableLink = "timetable_link"
        case zoomLink = "zoom_link"
        case ownDiplomaDeadline = "own_diploma_deadline"
        case universityDiplomaDeadline = "university_diploma_deadline"
        case workDiplomaDeadline = "work_diploma_deadline"
        case themes = "themes"
    }
}
