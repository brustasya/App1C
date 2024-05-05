//
//  CreateThemeSelectionEventPresenter.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

class CreateThemeSelectionEventPresenter {
    weak var viewInput: ThemeSelectionEventViewInput?
    
    private let eventsService: EventsServiceProtocol
    
    init(
        eventsService: EventsServiceProtocol
    ) {
        self.eventsService = eventsService
    }
    
    private func createEvent(model: CreateThemeSelectionModel) {
        eventsService.createThemeSelectionEvent(model: model) { [weak self] result in
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

extension CreateThemeSelectionEventPresenter: ThemeSelectionEventViewOutput {
    func createButtonTapped(model: ThemeSelectionEventModel) {
        let createEventModel = CreateThemeSelectionModel(
            title: EventType.diplomaThemeChoice.title,
            description: model.descrURL ?? "",
            themes: model.themesURL,
            commonDeadline: Date.toString(date: model.commonDeadline),
            ownDiplomaDeadline: Date.toString(date: model.ownDeadline),
            universityDiplomaDeadline: Date.toString(date: model.departmentDeadline),
            workDiplomaDeadline: Date.toString(date: model.workDeadline),
            type: EventType.diplomaThemeChoice.rawValue
        )
        createEvent(model: createEventModel)
    }
    
    func saveButtonTapped(model: ThemeSelectionEventModel) { }
    
    func viewIsReady() {
        viewInput?.setupCreateMode()
    }
}
