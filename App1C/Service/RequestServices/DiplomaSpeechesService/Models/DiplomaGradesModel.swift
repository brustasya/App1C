//
//  DiplomaGradesModel.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

struct DiplomaGradesModel: Codable {
    let students: [DiplomaGradeServiceModel]
}

struct DiplomaGradeServiceModel: Codable {
    let studentID: Int
    let fullName: String
    let result: Int?
    let gradeID: Int
    
    enum CodingKeys: String, CodingKey {
        case studentID = "student_id"
        case fullName = "full_name"
        case result = "result"
        case gradeID = "grade_id"
    }
}
