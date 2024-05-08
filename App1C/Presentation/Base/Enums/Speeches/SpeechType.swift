//
//  SpeechType.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

enum SpeechType: String {
    case rw1 = "CONTROL_OF_RESEARCH_WORK_1"
    case rw2 = "CONTROL_OF_RESEARCH_WORK_2"
    case rw3 = "CONTROL_OF_RESEARCH_WORK_3"
    case predefending = "PREDEFENDING"
    case defending = "DEFENDING"
    
    var title: String {
        switch self {
        case .rw1:
            return "Контроль НИР №1"
        case .rw2:
            return "Контроль НИР №2"
        case .rw3:
            return "Контроль НИР №3"
        case .predefending:
            return "Предзащита"
        case .defending:
            return "Защита"
        }
    }
}
