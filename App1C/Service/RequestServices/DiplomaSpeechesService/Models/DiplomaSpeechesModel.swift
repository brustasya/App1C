//
//  DiplomaSpeechesModel.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

struct DiplomaSpeechesModel: Codable {
    let students: [DiplomaSpeecheServiceModel]
}

struct DiplomaSpeecheServiceModel: Codable {
    let studentID: Int
    let fullName: String?
    let theme: String?
    let result: Bool
    let speechID: Int
    
    enum CodingKeys: String, CodingKey {
        case studentID = "student_id"
        case fullName = "full_name"
        case theme = "theme"
        case result = "result"
        case speechID = "speech_id"
    }
}
