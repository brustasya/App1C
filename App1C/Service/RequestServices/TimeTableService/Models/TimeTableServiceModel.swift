//
//  TimeTableServiceModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct TimeTableServiceModel: Codable {
    let days: [DayModel]
    let coursesWithoutTimetable: [TimeTableCourseModel]
    
    enum CodingKeys: String, CodingKey {
        case days = "days"
        case coursesWithoutTimetable = "courses_without_timetable"
    }
}

struct DayModel: Codable {
    let dayOfWeek: Int
    let courses: [TimeTableCourseModel]
    
    enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case courses = "courses"
    }
}

struct TimeTableCourseModel: Codable {
    let courseID: Int
    let dayOfWeek: Int?
    let name: String
    let from: String?
    let to: String?
    
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case dayOfWeek = "day_of_week"
        case name = "name"
        case from = "from"
        case to = "to"
    }
}
