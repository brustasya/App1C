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
}

extension NotificationsPresenter: NotificationsViewOutput {
    func viewIsReady() {
        getEvents()
    }
    
    func viewWillAppear() {
        getEvents()
    }
    
    func selectedRowAt(index: Int) {
        moduleOutput?.moduleWantsToOpenNotification(id: events[index].id)
    }
    
    
}
