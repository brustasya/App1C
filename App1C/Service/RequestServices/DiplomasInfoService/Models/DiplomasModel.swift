//
//  DiplomasModel.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

struct DiplomasModel: Codable {
    let processID: Int
    let diplomas: [DiplomaServiceModel]
    
    enum CodingKeys: String, CodingKey {
        case processID = "process_id"
        case diplomas = "diplomas"
    }
}

struct DiplomaServiceModel: Codable {
    let studentID: Int
    let studentFullName: String
    let theme: String?
    
    enum CodingKeys: String, CodingKey {
        case studentID = "student_id"
        case studentFullName = "student_full_name"
        case theme = "theme"
    }
}

