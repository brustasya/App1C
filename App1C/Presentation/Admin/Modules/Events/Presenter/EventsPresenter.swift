//
//  EventsPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

final class EventsPresenter {
    weak var viewInput: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    
    private let eventsService: EventsServiceProtocol
    private lazy var events: [EventModel] = []
    
    
    init(
        moduleOutput: EventsModuleOutput,
        eventsService: EventsServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.eventsService = eventsService
    }
    
    func getEvents() {
        eventsService.currentEvents() { [weak self] result in
            switch result {
            case .success(let model):
                let events = model.events.map({ EventModel(
                    id: $0.id,
                    title: $0.title,
                    deadline: Date.toDate(dateString: $0.deadline),
                    type: (self?.getEventType(type: $0.type ?? "")) ?? .estimating
                )})
                self?.events = events
                DispatchQueue.main.async {
                    self?.viewInput?.updateEvents(events: events)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load evets: \(error)")
            }
        }
    }
    
    private func getEventType(type: String) -> EventType {
        switch type {
        case EventType.preliminaryCourseChoice.rawValue:
            return .preliminaryCourseChoice
        case EventType.finalCourseChoice.rawValue:
            return .finalCourseChoice
        case EventType.estimating.rawValue:
            return .estimating
        case EventType.diplomaSpeech.rawValue:
            return .diplomaSpeech
        case EventType.diplomaThemeChoice.rawValue:
            return .diplomaThemeChoice
        case EventType.diplomaThemeCorrection.rawValue:
            return .diplomaThemeCorrection
        default:
            return .message
        }
    }
}

extension Date {
    public static func toDate(dateString: String?) -> Date {
        guard let dateString else { return Date() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}

extension EventsPresenter: EventsViewOutput {
    
    func createEvent(type: EventType) {
        moduleOutput?.moduleWantsToCreateEvent(type: type)
    }
    
    func createThemeSelectionEvent() {
        moduleOutput?.moduleWantsToCreateThemeSelectionEvent()
    }
    
    func createDiplomaSpeechEvent() {
        moduleOutput?.moduleWantsToCreateDiplomaSpeechEvent()
    }
    
    func viewIsReady() {
        getEvents()
    }
    
    func viewWillAppear() {
        getEvents()
    }
    
    func selectRow(at index: Int) {
        switch events[index].type {
        case .diplomaThemeChoice:
            moduleOutput?.moduleWantsToOpenThemeSelectionEvent(id: events[index].id)
        case .diplomaSpeech:
            moduleOutput?.moduleWantsToOpenDiplomaSpeechEvent(id: events[index].id)
        default:
            moduleOutput?.moduleWantsToOpenEvent(id: events[index].id)
        }
    }
}
