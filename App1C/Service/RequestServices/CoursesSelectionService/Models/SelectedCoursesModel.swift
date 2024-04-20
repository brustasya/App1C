//
//  SelectedCoursesModel.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

struct SelectedCoursesModel: Codable {
    let courses: [SelectedCourseServiceModel]
}

struct SelectedCourseServiceModel: Codable {
    let courseID: Int
    let takenAsLoad: Bool
    let isOffline: Bool
    
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case takenAsLoad = "taken_as_load"
        case isOffline = "is_offline"
    }
}

struct CoursesIDModel: Codable {
    let courses: [Int]
}
