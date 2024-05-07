//
//  NotificationsPresenter.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

class NotificationsPresenter {
    weak var viewInput: NotificationsViewInput?
    weak var moduleOutput: NotificationsModuleOutput?
    
    private let eventsService: EventsServiceProtocol
    
    private var events: [NotificationModel] = []
    
    init(
        moduleOutput: NotificationsModuleOutput,
        eventsService: EventsServiceProtocol
    ) {
        self.eventsService = eventsService
        self.moduleOutput = moduleOutput
    }
    
    private func getEvents() {
        eventsService.events() { [weak self] result in
            switch result {
            case .success(let model):
                let events = model.events.map({ NotificationModel(id: $0.id, title: $0.title, deadline: Date.toDate(dateString: $0.deadline), newEvent: $0.newEvent ?? false) })
                self?.events = events
                DispatchQueue.main.async {
                    self?.viewInput?.setupEvents(with: events)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load events: \(failure)")
            }
        }
    }
    
    private func watchedEvent(id: Int) {
        eventsService.watchEvent(eventID: id) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success watch event")
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed watch event: \(failure)")
            }
        }
    }
}

extension NotificationsPresenter: NotificationsViewOutput {
    func viewIsReady() {
        getEvents()
    }
    
    func viewWillAppear() {
        getEvents()
    }
    
    func selectedRowAt(index: Int) {
        watchedEvent(id: events[index].id)
        if events[index].title == EventType.diplomaThemeChoice.title {
            moduleOutput?.moduleWantsToOpenThemeSelectionEvent(id: events[index].id)
        } else if events[index].title == SpeechType.rw1.title ||
                    events[index].title == SpeechType.rw2.title ||
                    events[index].title ==  SpeechType.rw3.title ||
                    events[index].title == SpeechType.predefending.title ||
                    events[index].title ==  SpeechType.defending.title
        {
            moduleOutput?.moduleWantsToOpenDiplomaSpeechEvent(id: events[index].id)
        } else {
            moduleOutput?.moduleWantsToOpenNotification(id: events[index].id)
        }
    }
    
    
}
