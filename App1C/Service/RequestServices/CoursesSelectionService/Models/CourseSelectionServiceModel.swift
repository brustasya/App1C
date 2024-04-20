//
//  CourseSelectionServiceModel.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

struct PreliminaryChoiceModel: Codable {
    let amount: Int
    let courses: [CourseSelectionServiceModel]
}

struct CourseSelectionServiceModel: Codable {
    let id: Int
    let title: String
    let dependencies: [DependenceModel]
    let closed: Bool?
    let wasInLoad: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "course_id"
        case title = "name"
        case dependencies = "dependencies"
        case closed = "closed"
        case wasInLoad = "was_in_load"
    }
}

struct DependenceModel: Codable {
    let id: Int
    let title: String
    let closed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "course_id"
        case title = "name"
        case closed = "closed"
    }
}
