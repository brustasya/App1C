//
//  CreateDiplomaSpeechModel.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

struct CreateDiplomaSpeechModel: Codable {
    let title: String
    let description: String
    let timetableLink: String
    let zoomLink: String?
    let deadline: String?
    let speechType: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case timetableLink = "timetable_link"
        case zoomLink = "zoom_link"
        case deadline = "deadline"
        case speechType = "speech_type"
    }
}
