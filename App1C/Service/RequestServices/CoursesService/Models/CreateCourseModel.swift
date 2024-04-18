//
//  CreateCourseModel.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

struct CreateCourseModel: Codable {
    let title: String
    let description: String
    let chat: String
    let dependencies: [Int]
    let teachers: [Int]
    let type: String?
}
