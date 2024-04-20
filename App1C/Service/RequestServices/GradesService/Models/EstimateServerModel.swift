//
//  EstimateServerModel.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

struct EstimateServerModel: Codable {
    let grade: Int
    let isRetake: Bool
    
    enum CodingKeys: String, CodingKey {
        case grade = "grade"
        case isRetake = "is_retake"
    }
}
