//
//  ThemeSelectionEventPresenter.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

class ThemeSelectionEventPresenter {
    weak var viewInput: ThemeSelectionEventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let id: Int
    
    init(
        id: Int,
        eventsService: EventsServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
    }
    
    private func getEvent() {
        eventsService.eventDetails(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                let eventModel = ThemeSelectionEventModel(
                    descrURL: model.description,
                    themesURL: model.themes,
                    commonDeadline: Date.toDate(dateString: model.deadline),
                    ownDeadline: Date.toDate(dateString: model.ownDiplomaDeadline),
                    departmentDeadline: Date.toDate(dateString: model.universityDiplomaDeadline),
                    workDeadline: Date.toDate(dateString: model.workDiplomaDeadline)
                )
                DispatchQueue.main.async {
                    self?.viewInput?.updateData(model: eventModel, isEdit: false)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
            }
        }
    }
}

extension ThemeSelectionEventPresenter: ThemeSelectionEventViewOutput {
    func createButtonTapped(model: ThemeSelectionEventModel) { }
    
    func saveButtonTapped(model: ThemeSelectionEventModel) { }
    
    func viewIsReady() {
        viewInput?.setupReadMode()
        getEvent()
    }
}
