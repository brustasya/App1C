//
//  GradeModel.swift
//  App1C
//
//  Created by Станислава on 05.04.2024.
//

import UIKit

struct GradeModel {
    let grade: Int
    var text: String {
        switch grade {
        case 1...2:
            return "неуд(\(grade))"
        case 3...4:
            return "уд(\(grade))"
        case 5...7:
            return "хор(\(grade))"
        case 8...10:
            return "отл(\(grade))"
        default:
            return "Нет оценки"
        }
    }
    var color: UIColor? {
        switch grade {
        case 1...2:
            return Colors.lightRed.uiColor
        case 3...4:
            return Colors.orange.uiColor
        case 5...7:
            return Colors.lightGreen.uiColor
        case 8...10:
            return Colors.green.uiColor
        default:
            return .systemGray6
        }
    }
    
    var textColor: UIColor? {
        switch grade {
        case 1...10:
            return .black
        default:
            return .gray
        }
    }
}
