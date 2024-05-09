//
//  AddStudentCoursesModel.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import Foundation

struct AddStudentCoursesModel: Codable {
    let courses: [AddStudentCourseModel]
}

struct AddStudentCourseModel: Codable {
    let id: Int
    let shouldCloseDependencies: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case shouldCloseDependencies = "should_close_dependencies"
    }
}
