//
//  TimeTablePresenter.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

final class TimeTablePresenter {
    weak var viewInput: TimeTableViewInput?
    weak var moduleOutput: TimeTableModuleOutput?
    
    private let timeTableService: TimeTableServiceProtocol
    
    private lazy var timeTableDict: [Int:[TimetableModel]] = [:]
    
    init(
        moduleOutput: TimeTableModuleOutput,
        timeTableService: TimeTableServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.timeTableService = timeTableService
    }
    
    private func getTimeTable() {
        timeTableService.timeTable() { result in
            switch result {
            case .success(let timeTable):
                for day in timeTable.days {
                    
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "TimeTable loading error: \(failure)")
            }
            
        }
    }
}
