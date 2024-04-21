//
//  TimeTableViewOutput.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

protocol TimeTableViewOutput: AnyObject {
    func openDay(day: Int)
    func viewIsReady()
}
