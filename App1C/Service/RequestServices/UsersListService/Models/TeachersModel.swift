//
//  TeachersModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct TeachersModel: Codable {
    let teachers: [ServerTeacherModel]
}

struct ServerTeacherModel: Codable {
    let id: Int
    let fullName: String
    let teachCourse: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
        case teachCourse = "teach_course"
    }
}
