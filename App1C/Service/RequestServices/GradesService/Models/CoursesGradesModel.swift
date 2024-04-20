//
//  CoursesGradesModel.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

struct CoursesGradesModel: Codable {
    let lastSemesters: [CourseGradeModel]
    let currentSemester: [CourseGradeModel]
    let unusedCourses: [CourseGradeModel]
    
    enum CodingKeys: String, CodingKey {
        case lastSemesters = "last_semesters"
        case currentSemester = "current_semester"
        case unusedCourses = "unused_courses"
    }
}

struct CourseGradeModel: Codable {
    let courseID: Int
    let courseTitle: String
    let isOffline: Bool
    let isRetake: Bool
    let grade: Int?
    let inLoad: Bool
    
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case courseTitle = "course_title"
        case isOffline = "is_offline"
        case isRetake = "is_retake"
        case grade = "grade"
        case inLoad = "in_load"
    }
}

//{
//  "last_semesters": [
//    {
//      "course_id": 0,
//      "course_title": "string",
//      "is_offline": true,
//      "is_retake": true,
//      "grade": 0,
//      "in_load": true
//    }
//  ],
//  "current_semester": [
//    {
//      "course_id": 0,
//      "course_title": "string",
//      "is_offline": true,
//      "is_retake": true,
//      "grade": 0,
//      "in_load": true
//    }
//  ],
//  "unused_courses": [
//    {
//      "course_id": 0,
//      "course_title": "string",
//      "is_offline": true,
//      "is_retake": true,
//      "grade": 0,
//      "in_load": true
//    }
//  ]
//}
//No links
//500
//Server error
