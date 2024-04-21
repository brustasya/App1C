//
//  TimeTablePresenter.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import Foundation

final class TimeTablePresenter {
    weak var viewInput: TimeTableViewInput?
    
    private let timeTableService: TimeTableServiceProtocol
    
    private lazy var timeTableDict: [Int:[TimetableModel]] = [:]
    
    init(
        timeTableService: TimeTableServiceProtocol
    ) {
        self.timeTableService = timeTableService
    }
    
    private func getTimeTable() {
        timeTableService.timeTable() { [weak self] result in
            switch result {
            case .success(let timeTable):
                for day in timeTable.days {
                    self?.timeTableDict[day.dayOfWeek] = day.courses.map({ TimetableModel(time: Date.toTime(fromString: $0.from, toString: $0.to), titles: [$0.name]) })
                }
                DispatchQueue.main.async {
                    self?.viewInput?.updateTimeTable(with: self?.timeTableDict[1] ?? [])
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "TimeTable loading error: \(failure)")
            }
            
        }
    }
}

extension TimeTablePresenter: TimeTableViewOutput {
    func openDay(day: Int) {
        viewInput?.updateTimeTable(with: timeTableDict[day] ?? [])
    }
    
    func viewIsReady() {
        getTimeTable()
    }
    
    
}

extension Date {
    public static func toTime(fromString: String?, toString: String?) -> String {
        guard let fromString, let toString else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let to = dateFormatter.date(from: toString) ?? Date()
        let from = dateFormatter.date(from: fromString) ?? Date()
        
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = "HH:mm"
        
        let toStr = timeDateFormatter.string(from: to)
        let fromStr = timeDateFormatter.string(from: from)
        
        return "\(fromStr)-\(toStr)"
    }
}
