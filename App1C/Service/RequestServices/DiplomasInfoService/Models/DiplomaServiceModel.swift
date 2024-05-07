//
//  DiplomaServiceModel.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

struct DiplomaInfoServiceModel: Codable {
    let bachelor: DiplomaDetailsServiceModel
    let master: DiplomaDetailsServiceModel
}

struct DiplomaDetailsServiceModel: Codable {
    let studentID: Int
    let studentFullName: String
    let theme: String?
    let type: String?
    let degree: String
    let isCurrentDiploma: Bool
    let adviserName: String?
    let adviserContacts: String?
    let adviserWorkplace: String?
    let adviserJob: String?
    let materialsLink: String?
    let grade: Int?
    
    enum CodingKeys: String, CodingKey {
        case studentID = "student_id"
        case studentFullName = "student_full_name"
        case theme = "theme"
        case type = "type"
        case degree = "degree"
        case isCurrentDiploma = "is_current_diploma"
        case adviserName = "adviser_name"
        case adviserContacts = "adviser_contacts"
        case adviserWorkplace = "adviser_workplace"
        case adviserJob = "adviser_job"
        case materialsLink = "materials_link"
        case grade = "grade"
    }
}
