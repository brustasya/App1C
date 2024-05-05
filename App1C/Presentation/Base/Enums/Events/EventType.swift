//
//  EventType.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import Foundation

enum EventType: String {
    case preliminaryCourseChoice = "PRELIMINARY_COURSE_CHOICE"
    case finalCourseChoice = "FINAL_COURSE_CHOICE"
    case diplomaThemeChoice = "DIPLOMA_THEME_CHOICE"
    case estimating = "ESTIMATING"
    case diplomaSpeech = "DIPLOMA_SPEECH"
    case diplomaThemeCorrection = "DIPLOMA_THEME_CORRECTION"
    case message = "MESSAGE"
    
    var title: String {
        switch self {
        case .preliminaryCourseChoice:
            return "Выбор курсов"
        case .finalCourseChoice:
            return "Выбор минимальной нагрузки"
        case .estimating:
            return "Выставление оценок"
        case .diplomaThemeChoice:
            return "Выбор темы диплома"
        case .diplomaSpeech:
            return "Контроль НИР\nПредзащита / Защита"
        case .diplomaThemeCorrection:
            return "Уточнение темы диплома"
        case .message:
            return "Сообщение от администратора"
        }
    }
}
