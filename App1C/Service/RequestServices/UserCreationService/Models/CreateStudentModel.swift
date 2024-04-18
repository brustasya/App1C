//
//  CreateStudentModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct CreateStudentModel: Codable {
    let secondName: String
    let firstName: String
    let surname: String
    let email: String
    let semester: Int
    
    enum CodingKeys: String, CodingKey {
        case secondName = "second_name"
        case firstName = "first_name"
        case surname = "surname"
        case email = "email"
        case semester = "semester"
    }
}

//{
//  "second_name": "string",
//  "first_name": "string",
//  "surname": "string",
//  "email": "string",
//  "semester": 0
//}
