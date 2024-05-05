//
//  CreateThemeSelectionModel.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

struct CreateThemeSelectionModel: Codable {
    let title: String
    let description: String
    let themes: String?
    let commonDeadline: String
    let ownDiplomaDeadline: String
    let universityDiplomaDeadline: String
    let workDiplomaDeadline: String
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case themes = "themes"
        case commonDeadline = "common_deadline"
        case ownDiplomaDeadline = "own_diploma_deadline"
        case universityDiplomaDeadline = "university_diploma_deadline"
        case workDiplomaDeadline = "work_diploma_deadline"
        case type = "type"
    }
}
