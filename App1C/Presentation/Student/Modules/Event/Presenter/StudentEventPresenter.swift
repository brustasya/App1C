//
//  StudentEventPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class StudentEventPresenter {
    weak var moduleOutput: StudentEventModuleOutput?
    weak var viewInput: EventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let id: Int
    private var eventType: EventType = .estimating
    
    init(
        id: Int,
        moduleOutput: StudentEventModuleOutput,
        eventsService: EventsServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
        self.moduleOutput = moduleOutput
    }
    
    private func getEvent() {
        eventsService.eventDetails(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventType = (self?.getEventType(type: model.type)) ?? .estimating
                DispatchQueue.main.async {
                    if self?.eventType != .diplomaThemeCorrection {
                        self?.viewInput?.addGoOverButton()
                    }
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
        case EventType.diplomaThemeCorrection.rawValue:
            return .diplomaThemeCorrection
        default:
            return .estimating
        }
    }
}

extension StudentEventPresenter: EventViewOutput {
    func selectCourse(at index: Int) { }
    
    func viewIsReady() {
        getEvent()
        viewInput?.setupReadMode()
    }
    
    func createButtonTapped(deadline: Date, descr: String) { }
    
    func goOverButtonTapped() {
        if eventType == .preliminaryCourseChoice {
            moduleOutput?.moduleWantsToOpenCourseSelection()
        } else {
            moduleOutput?.moduleWantsToOpenFinalCourseSelection()
        }
    }
    
    func saveButtonTapped(deadline: Date, descr: String) { }
    
    
}
