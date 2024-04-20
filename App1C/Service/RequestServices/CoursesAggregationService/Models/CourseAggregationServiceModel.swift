//
//  CourseAggregationServiceModel.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

struct CoursesAggregationServiceModel: Codable {
    let courses: [CourseAggregationServiceModel]
}

struct CourseAggregationServiceModel: Codable {
    let id: Int
    let title: String
    let offline: Int?
    let online: Int?
    let isStarted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case offline = "offline"
        case online = "online"
        case isStarted = "is_started"
    }
}

