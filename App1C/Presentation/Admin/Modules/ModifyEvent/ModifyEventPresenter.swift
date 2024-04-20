//
//  ModifyEventPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class ModifyEventPresenter {
    weak var moduleOutput: StudentEventModuleOutput?
    weak var viewInput: EventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let id: Int
    private var eventType: EventType = .estimating
    
    init(
        id: Int,
        eventsService: EventsServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
    }
    
    private func modifyEvent(model: EventDetailServiceModel) {
        eventsService.modifyEvent(eventID: id, eventModel: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success modify event")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed modify event: \(error)")
            }
        }
    }
    
    private func getEvent() {
        eventsService.getModifyEvent(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventType = (self?.getEventType(type: model.type)) ?? .estimating
                DispatchQueue.main.async {
                    self?.viewInput?.updateData(deadline: Date.toDate(dateString: model.deadline), descr: model.description)
                    self?.viewInput?.setTitle(title: model.title)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
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
        default:
            return .estimating
        }
    }
}

extension ModifyEventPresenter: EventViewOutput {
    func viewIsReady() {
        getEvent()
        viewInput?.setupSaveMode()
    }
    
    func createButtonTapped(deadline: Date, descr: String) { }
    
    func goOverButtonTapped() { }
    
    func saveButtonTapped(deadline: Date, descr: String) {
        let model = EventDetailServiceModel(id: id, title: eventType.title, description: descr, deadline: Date.toString(date: deadline), type: eventType.rawValue, speechType: nil, timetableLink: nil, zoomLink: nil, ownDiplomaDeadline: nil, universityDiplomaDeadline: nil, workDiplomaDeadline: nil, themes: nil)
        modifyEvent(model: model)
    }
    
    
}
