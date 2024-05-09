//
//  GetAddStudentCoursesModel.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import Foundation

struct GetAddStudentCoursesModel: Codable {
    let startedNotClosed: [ServerCourseModel]
    let closedNotCounted: [ServerCourseModel]
    
    enum CodingKeys: String, CodingKey {
        case startedNotClosed = "started_not_closed"
        case closedNotCounted = "closed_not_counted"
    }
}
