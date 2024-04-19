//
//  CoursesModel.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

struct CoursesModel: Codable {
    let courses: [ServerCourseModel]
}

struct ServerCourseModel: Codable {
    let id: Int
    let title: String
    let isTeacherCourse: Bool?
    let isCourseDependency: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isTeacherCourse = "is_teacher_course"
        case isCourseDependency = "is_course_dependency"
    }
}

//{
//  "courses": [
//    {
//      "id": 0,
//      "title": "string",
//      "is_teacher_course": true,
//      "is_course_dependency": true
//    }
//  ]
//}
