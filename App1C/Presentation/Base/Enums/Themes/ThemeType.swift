//
//  ThemeType.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

enum ThemeType: String {
    case own = "OWN"
    case work = "WORK"
    case department = "UNIVERSITY"
    var title: String {
        switch self {
        case .own:
            return "Своя тема"
        case .work:
            return "Тема от работы"
        case .department:
            return "Тема от кафедры"
        }
    }
}
