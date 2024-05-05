//
//  ModifyThemeSelectionEventPresenter.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

class ModifyThemeSelectionEventPresenter {
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
        eventsService.getModifyEvent(eventID: id) { [weak self] result in
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
                    self?.viewInput?.updateData(model: eventModel, isEdit: true)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
            }
        }
    }
    
    private func modifyEvent(model: EventDetailServiceModel) {
        eventsService.modifyEvent(eventID: id, eventModel: model) { [weak self] result in
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

extension ModifyThemeSelectionEventPresenter: ThemeSelectionEventViewOutput {
    func createButtonTapped(model: ThemeSelectionEventModel) { }
    
    func saveButtonTapped(model: ThemeSelectionEventModel) { 
        let modifyEventModel = EventDetailServiceModel(
            id: id,
            title: EventType.diplomaThemeChoice.title,
            description: model.descrURL ?? "",
            deadline: Date.toString(date: model.commonDeadline),
            type: EventType.diplomaThemeChoice.rawValue,
            speechType: nil,
            timetableLink: nil,
            zoomLink: nil,
            ownDiplomaDeadline: Date.toString(date: model.ownDeadline),
            universityDiplomaDeadline: Date.toString(date: model.departmentDeadline),
            workDiplomaDeadline: Date.toString(date: model.workDeadline),
            themes: model.themesURL
        )
        modifyEvent(model: modifyEventModel)
    }
    
    func viewIsReady() {
        viewInput?.setupSaveMode()
        getEvent()
    }
}
