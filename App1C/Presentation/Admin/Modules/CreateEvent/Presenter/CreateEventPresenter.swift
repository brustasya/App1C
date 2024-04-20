//
//  CreateEventPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

class CreateEventPresenter {
    weak var viewInput: EventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let eventType: EventType
    
    init(
        eventType: EventType,
        eventsService: EventsServiceProtocol
    ) {
        self.eventType = eventType
        self.eventsService = eventsService
    }
    
    private func createEvent(model: CreateEventModel) {
        eventsService.createEvent(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success create event")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed create event: \(error)")
            }
        }
    }
    
    private func createSemester(model: CreateSemesterModel) {
        eventsService.createSemester(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success create event")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed create event: \(error)")
            }
        }
    }
}

extension CreateEventPresenter: EventViewOutput {
    func viewIsReady() {
        viewInput?.setupCreateMode()
        viewInput?.setTitle(title: eventType.title)
    }
    
    func createButtonTapped(deadline: Date, descr: String) {
        let model = CreateEventModel(
            title: eventType.title,
            description: descr,
            deadline: Date.toString(date: deadline),
            type: eventType.rawValue
        )
        let semesterModel = CreateSemesterModel(
            title: eventType.title,
            description: descr,
            deadline: Date.toString(date: deadline)
        )
        if eventType == .preliminaryCourseChoice {
            createSemester(model: semesterModel)
        } else {
            createEvent(model: model)
        }
    }
    
    func goOverButtonTapped() { }
    
    func saveButtonTapped(deadline: Date, descr: String) { }
    
    
}

extension Date {
    public static func toString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
