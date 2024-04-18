//
//  StudentsModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct StudentsModel: Codable {
    let students: [ServerStudentModel]
    let estimationFinished: Bool?
    
    enum CodingKeys: String, CodingKey {
        case students = "students"
        case estimationFinished = "estimation_finished"
    }
}

struct ServerStudentModel: Codable {
    let id: Int
    let fullName: String
    let inAcademicLeave: Bool
    let grade: Int?
    let dependenciesClosed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
        case inAcademicLeave = "in_academic_leave"
        case grade = "grade"
        case dependenciesClosed = "dependencies_closed"
    }
}

//{
//  "students": [
//    {
//      "id": 0,
//      "full_name": "string",
//      "in_academic_leave": true,
//      "grade": 0,
//      "dependencies_closed": true
//    }
//  ],
//  "estimation_finished": true
//}
