//
//  TimeTableViewInput.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

protocol TimeTableViewInput: AnyObject {
    func updateTimeTable(with timeTable: [TimetableModel])
}
