//
//  CourseType.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

enum CourseType: String {
    case department = "DEPARTMENT"
    case ownWork = "OWN_WORK"
    case coupleOfLessons = "COUPLE_OF_LESSONS"
    case epr = "ERP"
    case hse = "HSE"
    case practise = "PRACTISE"
    
    var title: String {
        switch self {
        case .department:
            return "Кафедральный"
        case .ownWork:
            return "Самостоятельная работа"
        case .coupleOfLessons:
            return "Несколько занятий"
        case .epr:
            return "EPR"
        case .hse:
            return "Онлайн-курс во ВШЭ"
        case .practise:
            return "Практический курс"
        }
    }
}
