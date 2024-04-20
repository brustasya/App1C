//
//  FinalCourseSelectionServiceModels.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

struct FinalChoiceModel: Codable {
    let amount: Int
    let chosen: [ChoosenCourseSelectionServiceModel]
    let closedNotUsed: [ClosedCourseServerModel]
    let started: [CourseSelectionServiceModel]
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case chosen = "chosen"
        case closedNotUsed = "closed_not_used"
        case started = "started"
    }
}

struct ChoosenCourseSelectionServiceModel: Codable {
    let id: Int
    let title: String
    let dependencies: [DependenceModel]
    let isOffline: Bool
    let started: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "course_id"
        case title = "name"
        case dependencies = "dependencies"
        case isOffline = "is_offline"
        case started = "started"
    }
}


struct ClosedCourseServerModel: Codable {
    let courseID: Int
    let name: String
    let grade: Int
    
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case name = "name"
        case grade = "grade"
    }
}
