//
//  DiplomaSpeechesServiceModel.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

struct DiplomaSpeechesResultsServiceModel: Codable {
    let speeches: [DiplomaSpeecheResultServiceModel]
}

struct DiplomaSpeecheResultServiceModel: Codable {
    let id: Int
    let speechType: String?
    let result: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case speechType = "speech_type"
        case result = "result"
    }
}
